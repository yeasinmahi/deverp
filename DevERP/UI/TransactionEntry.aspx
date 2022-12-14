<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="TransactionEntry.aspx.cs" Inherits="DevERP.UI.TransactionEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .error {
            color: red;
            display: inline-block !important;
        }
    </style>
    <script>
        $(document).ready(function () {
            $("#MainContent_transactionDate").datepicker({
                autoclose: true,
                todayHighlight: true,
                format: "dd/mm/yyyy"
            });
            $("#myForm").validate({
                rules: {
                    ctl00$MainContent$transactionDate: {
                        required: true,
                        date: true
                    },
                    ctl00$MainContent$itemNameDropDown: {
                        required: {
                            depends: function () {
                                if ('0' === $('#MainContent_itemNameDropDown').val()) {
                                    //Set predefined value to blank.
                                    $('#MainContent_itemNameDropDown').val('');
                                }
                                return true;
                            }
                        }
                    },
                    ctl00$MainContent$amount: {
                        required: true,
                        number: true,
                        maxlength: 18
                    },
                    ctl00$MainContent$CatagoryDropDown: {
                        required: {
                            depends: function () {
                                if ('0' === $('#MainContent_CatagoryDropDown').val()) {
                                    //Set predefined value to blank.
                                    $('#MainContent_CatagoryDropDown').val('');
                                }
                                return true;
                            }
                        }
                    },
                    ctl00$MainContent$TypeDropDown: {
                        required: {
                            depends: function () {
                                if ('0' === $('#MainContent_TypeDropDown').val()) {
                                    //Set predefined value to blank.
                                    $('#MainContent_TypeDropDown').val('');
                                }
                                return true;
                            }
                        }
                    },
                    ctl00$MainContent$remarks: {
                        maxlength: 200
                    }
                },
                messages: {
                    ctl00$MainContent$transactionDate: {
                        required: "  Date can not be empty",
                        date: "  Check date format"
                    },
                    ctl00$MainContent$itemNameDropDown: "  A item should be select",
                    ctl00$MainContent$amount: {
                        required: "  amount can not be empty",
                        number: "  amount should be number",
                        maxlenght: "  amount can not execced 10^18"
                    },
                    ctl00$MainContent$CatagoryDropDown: "  A catagory should be select",
                    ctl00$MainContent$TypeDropDown: "  A type should be select",
                    ctl00$MainContent$remarks: {
                        maxlength: "  Should not be exceed 200 charecter"
                    }
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="col-lg-12">
            <div class="row main panel panel-primary">
                <div class="panel-heading">
                    <div class="panel-title">
                        <h1 class="title">Transaction Entry</h1>
                    </div>
                </div>
                <div class="panel-body">
                    <div class="col-sm-12">
                        <hr />
                    </div>
                    <div class="form-group col-sm-12">
                        <div class="col-sm-12 control-label" runat="server" id="successMessage"></div>
                    </div>
                     <div class="form-group col-sm-12">
                        <asp:HiddenField runat="server" ID="transactionHidden"/>
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group col-sm-4">
                            <label class="col-sm-4 control-label">Transaction Date<b class="text-danger">*</b></label>
                            <div class="col-sm-8">
                                <input runat="server" class="form-control" type="text" id="transactionDate" name="transactionDate" placeholder="Ex DD/MM/YYYY" />
                            </div>
                        </div>
                        <div class="form-group col-sm-4">
                            <label class="col-sm-4 control-label">Item<b class="text-danger">*</b></label>
                            <div class="col-sm-8">
                                <asp:DropDownList runat="server" class="form-control" ID="itemNameDropDown" name="itemNameDropDown" AutoPostBack="True" OnSelectedIndexChanged="itemNameDropDown_OnSelectedIndexChanged"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group col-sm-4">
                            <label class="col-sm-4 control-label">Sub Item</label>
                            <div class="col-sm-8">
                                <asp:DropDownList runat="server" class="form-control" ID="subItemNameDropDown" name="subItemNameDropDown"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group col-sm-4">
                            <label class="col-sm-4 control-label">Amount<b class="text-danger">*</b></label>
                            <div class="col-sm-8">
                                <input runat="server" class="form-control" type="text" id="amount" name="amount" placeholder="Ex 1200.50" />
                            </div>
                        </div>
                        <div class="form-group col-sm-4">
                            <label class="col-sm-4 control-label">Transaction Catagory</label>
                            <div class="col-sm-8">
                                <asp:DropDownList runat="server" class="form-control" ID="CatagoryDropDown" name="CatagoryDropDown">
                                    <asp:ListItem Value="expence">Expence</asp:ListItem>
                                    <asp:ListItem Value="income">Income</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group col-sm-4">
                            <label class="col-sm-4 control-label">Party</label>
                            <div class="col-sm-8">
                                <asp:DropDownList runat="server" class="form-control" ID="partyDropDown" name="partyDropDown"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group col-sm-4">
                            <label class="col-sm-4 control-label">Transaction Type</label>
                            <div class="col-sm-8">
                                <asp:DropDownList runat="server" class="form-control" ID="TypeDropDown" name="TypeDropDown" AutoPostBack="True" OnTextChanged="TypeDropDown_OnTextChanged">
                                    <asp:ListItem Value="cash">Cash</asp:ListItem>
                                    <asp:ListItem Value="cheque">Cheque</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group col-sm-4">
                            <label class="col-sm-4 control-label">Bank</label>
                            <div class="col-sm-8">
                                <asp:DropDownList runat="server" class="form-control" ID="bankDropDown" name="bankDropDown"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group col-sm-4">
                            <label class="col-sm-4 control-label">Remarks</label>
                            <div class="col-sm-8">
                                <input runat="server" class="form-control" type="text" id="remarks" name="remarks" placeholder="Write your remarks here" />
                            </div>
                        </div>
                    </div>
                    <div class="form-group col-sm-12">
                        <div class="col-sm-2">
                            <asp:Button CssClass="btn btn-default btn-block" type="submit" ID="SaveTransaction" Text="Save" runat="server" OnClick="SaveTransaction_OnClick" />
                        </div>
                        <div class="col-sm-2">
                            <asp:Button CssClass="btn btn-default btn-block" type="button" ID="CancelTransaction" formnovalidate="" Text="Cancel" runat="server" OnClick="CancelTransaction_OnClick" />
                        </div>
                        <div class="col-sm-8"></div>
                    </div>

                    <style>
                        #MainContent_TransactionGridView td, #MainContent_TransactionGridView th {
                            padding: 10px 0;
                        }
                    </style>
                    <div class="">
                        <asp:GridView ID="TransactionGridView" runat="server" HorizontalAlignmnet="Center" CellPadding="4" ForeColor="#333333" ShowFooter="True"
                            GridLines="None" AutoGenerateColumns="False" Width="100%" AllowPaging="true" OnPageIndexChanging="TransactionGridView_OnPageIndexChanging" PageSize="5">
                            <Columns>
                                <asp:TemplateField HeaderText="#SL NO">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Transaction Id" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="id" runat="server" Text='<%# Eval("TransactionId") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Transaction Date">
                                    <ItemTemplate>
                                        <asp:Label ID="transactionDate" runat="server" Text='<%# Convert.ToDateTime(Eval("TransactionDate")).ToShortDateString() %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Item">
                                    <ItemTemplate>
                                        <asp:Label ID="itemName" runat="server" Text='<%# Eval("ItemName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sub-Item">
                                    <ItemTemplate>
                                        <asp:Label ID="subItemName" runat="server" Text='<%# Eval("SubItemName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="TotalLabel" runat="server" Text="Balance"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount">
                                    <ItemTemplate>
                                        <asp:Label ID="amount" runat="server" Text='<%# Eval("Amount") %>'></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="balance" runat="server" Text="N/A"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Transaction Catagory">
                                    <ItemTemplate>
                                        <asp:Label ID="transactionCatagory" runat="server" Text='<%# Eval("Catagory") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Party">
                                    <ItemTemplate>
                                        <asp:Label ID="partyName" runat="server" Text='<%# Eval("PartyName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Transaction Type">
                                    <ItemTemplate>
                                        <asp:Label ID="transactionType" runat="server" Text='<%# Eval("PaymentType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bank">
                                    <ItemTemplate>
                                        <asp:Label ID="bankName" runat="server" Text='<%# Eval("BankName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="status" runat="server" Text='<%# Eval("ChequeStatus") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks">
                                    <ItemTemplate>
                                        <%--<asp:Label ID="remarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>--%>
                                        <asp:TextBox ID="remarks" runat="server" Text='<%# Eval("Remarks") %>' TextMode="MultiLine" Rows="1"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%# Eval("TransactionId")%>' Text="Edit" OnClick="lnkEdit_OnClick"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Item">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkRemove" runat="server" CommandArgument='<%# Eval("TransactionId")%>' OnClientClick="return confirm('Do you want to delete?')" Text="Delete" OnClick="lnkRemove_OnClick"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <AlternatingRowStyle BackColor="White" />
                            <EditRowStyle BackColor="#7C6F57" />
                            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#E3EAEB" HorizontalAlign="Center"/>
                            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F8FAFA" />
                            <SortedAscendingHeaderStyle BackColor="#246B61" />
                            <SortedDescendingCellStyle BackColor="#D4DFE1" />
                            <SortedDescendingHeaderStyle BackColor="#15524A" />

                        </asp:GridView>
                    </div>
                </div>
                <!-- Panel body-->
            </div>
            <!-- Main panel-->
        </div>
        <!-- col-sm-12-->
    </div>
    <!-- Container-->
</asp:Content>
