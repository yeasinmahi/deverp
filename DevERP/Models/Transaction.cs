using System;
namespace DevERP.Models
{
    [Serializable()]
    public class Transaction
    {
        public int TransactionId { get; set; }
        public DateTime TransactionDate { get; set; }
        public int ItemId { get; set; }
        public string ItemName { get; set; }
        public int SubItemId { get; set; }
        public string SubItemName { get; set; }
        public decimal Amount { get; set; }
        public string Catagory { get; set; }
        public int PartyId { get; set; }
        public string PartyName { get; set; }
        public string PaymentType { get; set; }
        public int BankId { get; set; }
        public string BankName { get; set; }
        public string Remarks { get; set; }
        public string ChequeStatus { get; set; }
        public DateTime LastModify { get; set; }
    }
}