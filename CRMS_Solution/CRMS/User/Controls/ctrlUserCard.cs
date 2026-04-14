using CRMS_Business;
using System.Windows.Forms;

namespace CRMS.User.Controls
{
    public partial class ctrlUserCard : UserControl
    {
        private int _UserID = -1;
        public int UserID => _UserID;

        private clsUser _User = null;
        public clsUser SelectedUserInfo => _User;

        public ctrlUserCard()
        {
            InitializeComponent();
        }

        private void _ResetDefaultValues()
        {
            _UserID = -1;
            lblUserName.Text = "[???]";
            lblUserID.Text = "[???]";
            lblIsActive.Text = "[???]";
        }

        private void _FilleUserDateInControls()
        {
            _UserID = _User.UserID;
            ctrlPersonCard1.LoadPersonInfo(_User.PersonID);
            lblUserID.Text = _User.UserID.ToString();
            lblUserName.Text = _User.UserName;
            lblIsActive.Text = _User.IsActive ? "Yes" : "No";
        }

        public delegate void LoadUserInfoBy(int ID);
        
        private void _CheckAndLoadUserInfo()
        {
            if (_User == null)
            {
                _ResetDefaultValues();
                return;
            }

            _FilleUserDateInControls();
        }

        public void LoadUserInfoByUserID(int UserID)
        {
            _User = clsUser.FindByUserID(UserID);
            _CheckAndLoadUserInfo();
        }

        public void LoadUserInfoByPersonID(int PersonID)
        {
            _User = clsUser.FindByPersonID(PersonID);
            _CheckAndLoadUserInfo();
        }
    }
}