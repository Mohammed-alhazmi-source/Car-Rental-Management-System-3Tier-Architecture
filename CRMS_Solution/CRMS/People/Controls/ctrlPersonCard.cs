using CRMS.GlobalClasses;
using CRMS.Properties;
using CRMS_Business;
using System.IO;
using System.Windows.Forms;

namespace CRMS.People.Controls
{
    public partial class ctrlPersonCard : UserControl
    {

        private int _PersonID = -1;
        public int PersonID => _PersonID;

        private clsPerson _Person = null;
        public clsPerson SelectedPersonInfo => _Person;

        private void _LoadPersonImage()
        {
            if (_Person == null)
            {
                pbPersonImage.Image = Resources.Male_512;
                return;
            }

            if (string.IsNullOrEmpty(_Person.ImagePath))
            {
                if (_Person.Gender == (byte)clsEnums.enGender.Male)
                    pbPersonImage.Image = Resources.Male_512;

                else
                    pbPersonImage.Image = Resources.Female_512;

                return;
            }

            if (!string.IsNullOrEmpty(_Person.ImagePath))
            {
                if (File.Exists(_Person.ImagePath))
                {
                    pbPersonImage.ImageLocation = _Person.ImagePath;
                    return;
                }

                pbPersonImage.ImageLocation = $"Not Found ImagePath : {_Person.ImagePath}";
            }
        }

        private void _ResetDefaultValues()
        {
            llEditPersonInfo.Enabled = false;
            lblPersonID.Text = "[???]";
            lblPersonName.Text = "[???]";
            lblNationalNo.Text = "[???]";
            lblGender.Text = "[???]";
            lblEmail.Text = "[???]";
            lblAddress.Text = "[???]";
            lblDateOfBirth.Text = "[???]";
            lblPhone.Text = "[???]";
            lblCountry.Text = "[???]";
            _LoadPersonImage();
        }

        private void _FillPersonInfoInControls()
        {
            llEditPersonInfo.Enabled = true;
            _PersonID = _Person.PersonID;
            lblPersonID.Text = _PersonID.ToString();
            lblPersonName.Text = _Person.FullName;
            lblNationalNo.Text = _Person.NationalNo;
            lblGender.Text = (_Person.Gender == (byte)clsEnums.enGender.Male ? "Male" : "Female");
            lblEmail.Text = _Person.Email;
            lblAddress.Text = _Person.Address;
            lblDateOfBirth.Text = clsFormat.DateToString(_Person.DateOfBirth);
            lblPhone.Text = _Person.Phone;
            lblCountry.Text = _Person.CountryInfo.CountryName;
            _LoadPersonImage();
        }

        public void LoadPersonInfo(int PersonID)
        {
            _Person = clsPerson.Find(PersonID);

            if (_Person == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Person With ID = {PersonID}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                _PersonID = -1;
                return;
            }
            _FillPersonInfoInControls();
        }

        public void LoadPersonInfo(string NationalNo)
        {
            _Person = clsPerson.Find(NationalNo);

            if (_Person == null)
            {
                _ResetDefaultValues();
                MessageBox.Show($"No Person With NationalNo = {NationalNo}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                _PersonID = -1;
                return;
            }
            _FillPersonInfoInControls();
        }

        public ctrlPersonCard()
        {
            InitializeComponent();
        }

        private void UpdatePerson_DataBack(int PersonID)
        {
            LoadPersonInfo(PersonID);
        }

        private void llEditPersonInfo_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            frmAddUpdatePerson UpdatePerson = new frmAddUpdatePerson(_PersonID);
            UpdatePerson.DataBack += UpdatePerson_DataBack;
            UpdatePerson.ShowDialog();
        }
    }
}