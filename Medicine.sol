pragma solidity ^0.6.4;
pragma experimental ABIEncoderV2;
contract Medicine{
        address public creatorAdmin=0x61E9c1b88E7f131F62AE1372aA8778c773712439;
        enum Type {Dev,CEO}
        enum State {Pending,Approved}
        
        struct static_Medi_Detail{
        
        uint Bid;
        string Name;
        string qnty;
        string mfd_by;
        string mfd_in;
        string about;
        int MRP;
        
    }
    
    struct dynam_Medi_Detail{
        
        uint Bid;
        string Batch_Id;
        string MFD_on;
        string Exp; 
        address insertedBy;
        State state; 
    }
    
    struct request_new_dev{
        address dev_add;
        string dev_name;
        string dev_dob;
        string dev_pwd;
        State dev_state;
        address Approvedby;
    }
    
    
    
    // Mapping
    mapping(address=>request_new_dev) request_new_devs;
    mapping(uint=>static_Medi_Detail) static_Medi_Details;
    mapping(uint=>dynam_Medi_Detail) dynam_Medi_Details;
    
    
    modifier onlyCEO{
        require(msg.sender==creatorAdmin);
        _;
    }
    modifier onlyDev{
        require(request_new_devs[msg.sender].dev_state==State.Approved);
        _;
    }
    function add_dev(string memory name,string memory dob,string memory pwd) public{
        request_new_devs[msg.sender]=request_new_dev(msg.sender,name,dob,pwd,State.Pending,address(0));
        
    }
    
    function approve_dev(address dev_acc) onlyCEO public returns (bool success){
        request_new_devs[dev_acc].dev_state=State.Approved;
        request_new_devs[dev_acc].Approvedby=msg.sender;
        return true;
    }
    function approve_medi(uint BID) onlyCEO public returns(bool success){
        dynam_Medi_Details[BID].state=State.Approved;
        return true;
    }
    function add_new_medi(uint BID,string memory name,string memory wt,string memory mfg_by,string memory mfg_in,string memory desc,int rate,string memory batch,string memory mfd_date,string memory expire) public
    {
        static_Medi_Details[BID] = static_Medi_Detail(BID,name,wt,mfg_by,mfg_in,desc,rate);
        dynam_Medi_Details[BID] = dynam_Medi_Detail(BID,batch,mfd_date,expire,msg.sender,State.Pending);

    }    
    
    
    function modify_medi_batch(uint BID,string memory batch,string memory mfd_date,string memory expire) public
    {
        dynam_Medi_Details[BID].Batch_Id = batch;
        dynam_Medi_Details[BID].MFD_on = mfd_date;
        dynam_Medi_Details[BID].Exp = expire;
        dynam_Medi_Details[BID].insertedBy = msg.sender;
        dynam_Medi_Details[BID].state = State.Pending;

    }    
    
    function get_info(uint bcd) view public returns(string memory,string memory,string memory,string memory,string memory,int,string memory,string memory,string memory){ 
        static_Medi_Detail storage M = static_Medi_Details[bcd];
        dynam_Medi_Detail storage B = dynam_Medi_Details[bcd];
       return (M.Name, M.qnty, M.mfd_by, M.mfd_in, M.about,M.MRP,B.Batch_Id,B.MFD_on,B.Exp);}
    
    function get_dev(address acc) view public returns(address ,string memory ,string memory ,State){
        request_new_dev storage R = request_new_devs[acc];
        return(R.dev_add,R.dev_name,R.dev_dob,R.dev_state);
    }
    function medi_status(uint bcd) view public returns(uint,address,State){
        dynam_Medi_Detail storage D = dynam_Medi_Details[bcd];
        return (D.Bid,D.insertedBy,D.state);
    }
    function test(string memory x) pure public returns(string memory){
            return (x);
    }
}
