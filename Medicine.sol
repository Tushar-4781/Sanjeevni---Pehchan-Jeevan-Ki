pragma solidity ^0.6.4;
pragma experimental ABIEncoderV2;
contract Medicine{
    
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
    }
    
    
    // Mapping
    mapping(uint=>static_Medi_Detail) static_Medi_Details;
    mapping(uint=>dynam_Medi_Detail) dynam_Medi_Details;
    
    
    function add_new_medi(uint BID,string memory name,string memory wt,string memory mfg_by,string memory mfg_in,string memory desc,int rate,string memory batch,string memory mfd_date,string memory expire) public
    {
        static_Medi_Details[BID] = static_Medi_Detail(BID,name,wt,mfg_by,mfg_in,desc,rate);
        dynam_Medi_Details[BID] = dynam_Medi_Detail(BID,batch,mfd_date,expire);

        
    }    
    
    function modify_medi_batch(uint BID,string memory batch,string memory mfd_date,string memory expire) public
    {
        dynam_Medi_Details[BID].Batch_Id = batch;
        dynam_Medi_Details[BID].MFD_on = mfd_date;
        dynam_Medi_Details[BID].Exp = expire;

    }    
    
    function get_info(uint bcd) view public returns(string memory,string memory,string memory,string memory,string memory,int,string memory,string memory,string memory){ 
        static_Medi_Detail storage M = static_Medi_Details[bcd];
        dynam_Medi_Detail storage B = dynam_Medi_Details[bcd];
       return (M.Name, M.qnty, M.mfd_by, M.mfd_in, M.about,M.MRP,B.Batch_Id,B.MFD_on,B.Exp);}
    
    function test(string memory x) pure public returns(string memory){
            return (x);
    }
}