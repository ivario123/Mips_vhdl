


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SecondMipsVersion is
  port(
    Clk : in std_logic;
    Reset : in std_logic;
    dbg_reg : in std_logic_vector(4 downto 0);
    dbg_reg_data : out std_logic_vector(31 downto 0);
    dbg_dm_reg : in std_logic_vector(4 downto 0);
    dbg_dm_reg_data : out std_logic_vector(31 downto 0)
  );
end SecondMipsVersion;



architecture Behavioral of SecondMipsVersion is
-- Controll unit
component ControlUnit is
	port(
        Opcode : in std_logic_vector(5 downto 0);
        funct : in std_logic_vector(5 downto 0);
        Z : in std_logic;
        RegDestination, WriteEnable, ALUSource,Jump,Branch,MemWE,MemToReg : out std_logic;
        ALUControl : out std_logic_vector(2 downto 0)
	);
end component;

-- Arithmetic logic
component ALU_32 is
    port(
        A, B : in std_logic_vector(31 downto 0);
        SUB : in std_logic;
        Op : in std_logic_vector(1 downto 0);
        R : out std_logic_vector(31 downto 0);
        V, C, Z : out std_logic);
end component;

-- Bitwise operators

component SignExtend is
    port(A : in std_logic_vector(15 downto 0);
        B : out std_logic_vector(31 downto 0));
end component;

-- Multi plexer
component Two_to_one_mux_5 is
    port(
        A, B : in std_logic_vector(4 downto 0);
        Op : in std_logic;
        R : out std_logic_vector(4 downto 0));
end component;

component Two_to_one_mux_32 is
    port(
        A, B : in std_logic_vector(31 downto 0);
        Op : in std_logic;
        R : out std_logic_vector(31 downto 0));
end component;


-- Memory elements
component Latch32 is 
    port(S : in std_logic_vector(31 downto 0);
         Clk : in std_logic;
         Reset : in std_logic;
         Q : out std_logic_vector(31 downto 0));
end component;
component DataMemory is
    port ( Clk: in std_logic;
            Reset: in std_logic;
            MemWE : in std_logic;
            Address : in std_logic_vector(31 downto 0);
            DataIn : in std_logic_vector(31 downto 0);
            DataOut : out std_logic_vector(31 downto 0);
            dbg_dm_reg : in std_logic_vector(4 downto 0);
            dbg_dm_reg_data : out std_logic_vector(31 downto 0)
        );
end component;

component programmemory is
    port( address:in std_logic_vector(31 downto 0);
        instruction: out std_logic_vector(31 downto 0)
        );
end component;

component Regfile is
   port(
      clk: IN std_logic;
      reset: IN std_logic;
      A_data: OUT std_logic_vector(31 downto 0);
      B_data: OUT std_logic_vector(31 downto 0);
      A_addr: IN std_logic_vector(4 downto 0);
      B_addr: IN std_logic_vector(4 downto 0);
      W_data: IN std_logic_vector(31 downto 0);
      W_addr: IN std_logic_vector(4 downto 0);
      W_ena: IN std_logic;
      dbg_reg : IN std_logic_vector(4 downto 0);
      dbg_reg_data : OUT std_logic_vector(31 downto 0)
    );
end component;


-- Instruction counter
component PCPlus4 is
    port(
        Clk: in std_logic;
        Reset: in std_logic;
        Q: out std_logic_vector(31 downto 0));
end component;

-- Branch adder
component Adder32 is
    port (
        Cin : in std_logic;
        A, B : in std_logic_vector(31 downto 0);
        R : out std_logic_vector(31 downto 0);
        V,C : out std_logic
    );
 end component;

-- Bitshift 2
component BitShift is
    port(Num : in std_logic_vector(31 downto 0);
        R : out std_logic_vector(31 downto 0));
end component;
-- Internal signals
    -- Program counter
    signal PCP4 : std_logic_vector(31 downto 0);
    --  Control unit signals
    signal ALUSource, WriteEnable,RegDest,JumpCtrl,BranchCtrl,MemToReg : std_logic;
    signal ALUControl : std_logic_vector(2 downto 0);
    
    -- Register signals
    signal RD1,RD2 : std_logic_vector( 31 downto 0);  
    signal WriteReg : std_logic_vector(4 downto 0);
    -- Instruction memory signals
    signal Instruction,WriteData : std_logic_vector (31 downto 0);
    
    -- Data Memory signals
    signal MemWE : std_logic;
    signal MemDataOut : std_logic_vector(31 downto 0);
    
    -- SignExtend
    signal SigExtImm : std_logic_vector (31 downto 0);
    
    
    -- ALU outputs
    signal ALU_R : std_logic_vector(31 downto 0);
    signal V,C,Z : std_logic;
    -- ALU second input
    signal srcB : std_logic_vector(31 downto 0);
    
    -- Branch signals
    signal Offset, BRANCHP,BranchQ : std_logic_vector(31 downto 0);
    signal BranchSelect: std_logic;
    
    -- Jump Intermediate signals
    signal jmp,jmpext,jmpQ : std_logic_vector(31 downto 0);
    
    -- Pc signals
    signal PCP,PC : std_logic_vector(31 downto 0);
    
begin

    PClatch : Latch32 port map( S => PCP , Clk => Clk , Reset => Reset , Q => jmpQ );
    -- Instruction counter  
    pcplus : Adder32 port map( A => jmpQ , B => X"00000004" , Cin => '0', R => PCP4 );
    -- Instruction memory
    instrmem : programmemory port map( address => jmpQ, instruction => Instruction);
    -- 32 bit mux
    mux32 : Two_to_one_mux_32 port map(A =>RD2, B => SigExtImm,R => srcB,Op => ALUSource); 
    -- The extended value
    sigExt : SignExtend port map( A => Instruction(15 downto 0), B => SigExtImm);
    -- Register
    RegisterFile : Regfile port map(
      clk => Clk,
      reset => Reset,
      A_data => RD1,
      B_data => RD2,
      A_addr => Instruction(25 downto 21),
      B_addr => Instruction(20 downto 16),
      W_data => WriteData,
      W_addr => WriteReg,
      W_ena =>  WriteEnable,
      dbg_reg => dbg_reg,
      dbg_reg_data => dbg_reg_data);
    -- 5 bit mux
    mux5 : Two_to_one_mux_5  port map( A => Instruction(20 downto 16), B => Instruction(15 downto 11), R => WriteReg, Op => RegDest);
    -- The ALU
    ALU : ALU_32 port map( A => RD1, B=>srcB, Op => ALUControl(1 downto 0),Z => Z, R => ALU_R, V => V , C => C , SUB => ALUControl(2));
    -- Controll unit
    CTRL : ControlUnit port map( 
        Z => '0',
        Opcode => Instruction(31 downto 26),
        funct => Instruction(5 downto 0),
        Jump => JumpCtrl,
        MemWE => MemWE,
        MemToReg => MemToReg,
        Branch => BranchCtrl,
        RegDestination => RegDest,
        WriteEnable => WriteEnable,
        ALUSource => ALUSource,
        ALUControl => ALUControl);
    -- Data memory
    DataMem : DataMemory port map(
        Clk => Clk,
        Reset => Reset,
        MemWE => MemWE,
        Address => ALU_R, 
        DataIn => RD2,
        DataOut => MemDataOut,
        dbg_dm_reg => dbg_dm_reg, 
        dbg_dm_reg_data => dbg_dm_reg_data 
    );
    -- Multiplexer to chose what to write to the register
    MemToREGMUX : Two_to_one_mux_32 port map ( A => ALU_R, B => MemDataOut, R => WriteData, Op => MemToReg);
    -- Branch bitshift component
    BranchShifter: BitShift port map( Num => SigExtImm, R => Offset);
    -- Adder to offset the adress
    BranchAdder : Adder32 port map( A => Offset, B => PCP4, R => BRANCHP, Cin => '0');
    
    BranchSelect <= BranchCtrl and Z;
    -- Multiplexer to select if we want to branch
    BranchMux : Two_to_one_mux_32 port map(
        A => PCP4,
        B => BRANCHP,
        Op => BranchSelect,
        R => BranchQ);
    
    
    jmp(26 downto 0) <= Instruction(26 downto 0);
    jmp(31 downto 27) <= "00000";
    -- Jump shift adress
    JumpShifter : BitShift port map( Num => jmp, R => jmpext);
    -- Jump multiplexer
    JumpMux : Two_to_one_mux_32 port map( A => BranchQ, B => jmpext, Op => JumpCtrl, R => PCP);
    
    
end Behavioral;
