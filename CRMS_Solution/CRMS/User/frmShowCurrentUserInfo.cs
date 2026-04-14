using System;
using System.Windows.Forms;

namespace CRMS.User
{
    public partial class frmShowCurrentUserInfo : Form
    {
        public frmShowCurrentUserInfo(int UserID)
        {
            InitializeComponent();
            ctrlUserCard1.LoadUserInfoByUserID(UserID);
        }

        private void btnClose_Click(object sender, EventArgs e) => this.Close();
    }
}