using CRMS.GlobalClasses;
using CRMS.Properties;
using CRMS_Business;
using System;
using System.ComponentModel;
using System.Data;
using System.IO;
using System.Windows.Forms;

namespace CRMS.People
{  
    public partial class frmAddUpdatePerson : Form
    {
        public class AddUpdatePersonEventArgs : EventArgs
        {
            public clsPerson Person { get; }

            public AddUpdatePersonEventArgs(clsPerson person)
            {
                Person = person;
            }
        }

        public event EventHandler<AddUpdatePersonEventArgs> OnAddUpdatePerson;

        protected virtual void AddUpdatePerson(clsPerson Person)
        {
            OnAddUpdatePerson?.Invoke(this, new AddUpdatePersonEventArgs(Person));
        }

        private clsEnums.enMode _Mode = clsEnums.enMode.Add;

        private int _PersonID = -1;

        public event Action<int> DataBack;

        private clsPerson _Person = null;

        public frmAddUpdatePerson()
        {
            InitializeComponent();
            _Mode = clsEnums.enMode.Add;
        }

        public frmAddUpdatePerson(int PersonID)
        {
            InitializeComponent();
            _PersonID = PersonID;
            _Mode = clsEnums.enMode.Update;
        }

        public override bool ValidateChildren()
        {
            bool IsValid = true;
            if (string.IsNullOrEmpty(txtFirstName.Text))
            {
                IsValid = false;
                txtFirstName_Validating(txtFirstName, null);
            }
            if (string.IsNullOrEmpty(txtSecondName.Text))
            {
                IsValid = false;
                txtSecondName_Validating(txtSecondName, null);
            }
            if (string.IsNullOrEmpty(txtLastName.Text))
            {
                IsValid = false;
                txtLastName_Validating(txtLastName, null);
            }
            if (string.IsNullOrEmpty(txtNationalNo.Text))
            {
                IsValid = false;
                txtNationalNo_Validating(txtNationalNo, null);
            }
            if (string.IsNullOrEmpty(txtPhone.Text))
            {
                IsValid = false;
                txtPhone_Validating(txtPhone, null);
            }
            if (string.IsNullOrEmpty(txtAddress.Text))
            {
                IsValid = false;
                txtAddress_Validating(txtAddress, null);
            }


            return IsValid;
        }

        private void _FillCountriesInComboBox()
        {
            DataTable dtAllCountries = clsCountry.GetAllCountries();

            if (dtAllCountries == null)
                return;

            foreach (DataRow Row in clsCountry.GetAllCountries().Rows)
            {
                cbCountries.Items.Add(Row["CountryName"]);
            }

            cbCountries.SelectedIndex = cbCountries.FindString("Yemen");
        }

        private void _ResetDefaultValues()
        {
            _FillCountriesInComboBox();

            if (_Mode == clsEnums.enMode.Add)
            {
                lblTitle.Text = "Add New Person";
                lblPersonID.Text = "[???]";
                btnRemoveImage.Visible = false;
                _Person = new clsPerson();
            }
            else
            {
                lblTitle.Text = "Update Person";
            }

            dtpDateOfBirth.MaxDate = DateTime.Now.AddYears(-18);
            dtpDateOfBirth.MinDate = DateTime.Now.AddYears(-100);
            dtpDateOfBirth.Value = dtpDateOfBirth.MaxDate;

            txtFirstName.Text = "";
            txtSecondName.Text = "";
            txtThirdName.Text = "";
            txtLastName.Text = "";
            txtNationalNo.Text = "";
            rbMale.Checked = true;
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtAddress.Text = "";
            pbPersonImage.Image = Resources.Male_512;
        }

        private void _LoadPersonImage()
        {
            if (_Person.Gender == (byte)clsEnums.enGender.Male)
                pbPersonImage.Image = Resources.Male_512;

            else
                pbPersonImage.Image = Resources.Female_512;

            if (!string.IsNullOrEmpty(_Person.ImagePath))
            {
                if (File.Exists(_Person.ImagePath))
                    pbPersonImage.ImageLocation = _Person.ImagePath;
            }
        }

        private void _LoadPersonInfo()
        {
            _Person = clsPerson.Find(_PersonID);

            if (_Person == null)
            {
                MessageBox.Show($"No Person With ID = {_PersonID}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                _PersonID = -1;
                btnSave.Enabled = false;
                return;
            }

            lblPersonID.Text = _Person.PersonID.ToString();
            txtFirstName.Text = _Person.FirstName;
            txtSecondName.Text = _Person.SecondName;
            txtThirdName.Text = _Person.ThirdName;
            txtLastName.Text = _Person.LastName;
            txtNationalNo.Text = _Person.NationalNo;
            dtpDateOfBirth.Value = _Person.DateOfBirth;

            if (_Person.Gender == (byte)clsEnums.enGender.Male)
                rbMale.Checked = true;
            else
                rbFemale.Checked = true;

            cbCountries.SelectedIndex = cbCountries.FindString(_Person.CountryInfo.CountryName);
            txtEmail.Text = _Person.Email;
            txtPhone.Text = _Person.Phone;
            txtAddress.Text = _Person.Address;
            _LoadPersonImage();
        }

        private void _ValidateEmptyTextBox(object sender, EventArgs e)
        {
            TextBox Temp = (TextBox)sender;

            if (string.IsNullOrEmpty(Temp.Text))
                errorProvider1.SetError(Temp, "This Filed Is Required");

            else
                errorProvider1.SetError(Temp, null);
        }

        private void frmAddUpdatePerson_Load(object sender, EventArgs e)
        {
            _ResetDefaultValues();

            if (_Mode == clsEnums.enMode.Update)
                _LoadPersonInfo();
        }

        private void txtFirstName_Validating(object sender, CancelEventArgs e)
        {
            _ValidateEmptyTextBox(sender, e);
        }

        private void txtSecondName_Validating(object sender, CancelEventArgs e)
        {
            _ValidateEmptyTextBox(sender, e);
        }

        private void txtLastName_Validating(object sender, CancelEventArgs e)
        {
            _ValidateEmptyTextBox(sender, e);
        }

        private void txtNationalNo_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtNationalNo.Text))
            {
                _ValidateEmptyTextBox(sender, e);
                return;
            }

            if (_Mode == clsEnums.enMode.Update)
            {
                if (txtNationalNo.Text != _Person.NationalNo &&
                   clsPerson.IsExist(clsPerson.enColumn.NationalNo, txtNationalNo.Text.Trim()))
                {
                    e.Cancel = true;
                    errorProvider1.SetError(txtNationalNo, "National Number Is Used Another Person");
                }
                else
                {
                    e.Cancel = false;
                    errorProvider1.SetError(txtNationalNo, null);
                }
                return;
            }

            if (clsPerson.IsExist(clsPerson.enColumn.NationalNo, txtNationalNo.Text.Trim()))
            {
                e.Cancel = true;
                errorProvider1.SetError(txtNationalNo, "National Number Is Used Another Person");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtNationalNo, null);
            }
        }

        private void txtEmail_Validating(object sender, CancelEventArgs e)
        {
            // Check Format Email Address
            if (string.IsNullOrEmpty(txtEmail.Text))
            {
                e.Cancel = false;
                errorProvider1.SetError(txtEmail, null);
                return;
            }

            if (!clsValidation.ValidateEmail(txtEmail.Text.Trim()))
            {
                e.Cancel = true;
                errorProvider1.SetError(txtEmail, "Email Address InValid Format");
                return;
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtEmail, null);
            }


            //Mode Update
            if (_Mode == clsEnums.enMode.Update)
            {
                if (txtEmail.Text != _Person.Email &&
                    clsPerson.IsExist(clsPerson.enColumn.Email, txtEmail.Text.Trim()))
                {
                    e.Cancel = true;
                    errorProvider1.SetError(txtEmail, "Email Address Is Used Another Person");
                }
                else
                {
                    e.Cancel = false;
                    errorProvider1.SetError(txtEmail, null);
                }
                return;
            }

            //Mode Add
            if (clsPerson.IsExist(clsPerson.enColumn.Email, txtEmail.Text.Trim()))
            {
                e.Cancel = true;
                errorProvider1.SetError(txtEmail, "Email Address Is Used Another Person");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtEmail, null);
            }
        }

        private void txtPhone_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrEmpty(txtPhone.Text))
            {
                _ValidateEmptyTextBox(sender, e);
                return;
            }

            if (_Mode == clsEnums.enMode.Update)
            {
                if (txtPhone.Text != _Person.Phone &&
                    clsPerson.IsExist(clsPerson.enColumn.Phone, txtPhone.Text.Trim()))
                {
                    e.Cancel = true;
                    errorProvider1.SetError(txtPhone, "Phone Number Is Used Another Person");
                }
                else
                {
                    e.Cancel = false;
                    errorProvider1.SetError(txtPhone, null);
                }
                return;
            }

            // Mode Add
            if (clsPerson.IsExist(clsPerson.enColumn.Phone, txtPhone.Text.Trim()))
            {
                e.Cancel = true;
                errorProvider1.SetError(txtPhone, "Phone Number Is Used Another Person");
            }
            else
            {
                e.Cancel = false;
                errorProvider1.SetError(txtPhone, null);
            }
        }

        private void txtAddress_Validating(object sender, CancelEventArgs e)
        {
            _ValidateEmptyTextBox(sender, e);
        }

        private void txtPhone_KeyPress(object sender, KeyPressEventArgs e)
        {
            e.Handled = !char.IsDigit(e.KeyChar) && e.KeyChar != (char)Keys.Back;
        }

        private void btnChooseImage_Click(object sender, EventArgs e)
        {
            using (OpenFileDialog openFile = new OpenFileDialog())
            {
                openFile.Filter = "Image File |*.png;*.jpg;*.jpeg;*.gif";
                openFile.ShowDialog();

                if (!string.IsNullOrEmpty(openFile.FileName))
                {
                    pbPersonImage.ImageLocation = openFile.FileName;
                    btnRemoveImage.Visible = true;
                }
            }
        }

        private void btnRemoveImage_Click(object sender, EventArgs e)
        {
            pbPersonImage.ImageLocation = null;
            btnRemoveImage.Visible = false;

            if (rbMale.Checked)
                pbPersonImage.Image = Resources.Male_512;
            else
                pbPersonImage.Image = Resources.Female_512;
        }

        private void rbMale_CheckedChanged(object sender, EventArgs e)
        {
            if (pbPersonImage.ImageLocation != null)
                return;

            pbPersonImage.Image = Resources.Male_512;
        }

        private void rbFemale_CheckedChanged(object sender, EventArgs e)
        {
            if (pbPersonImage.ImageLocation != null)
                return;

            pbPersonImage.Image = Resources.Female_512;
        }

        private bool _HandlePersonImage()
        {
            string SourceFile = "";
            if (pbPersonImage.ImageLocation == null)
            {
                if (!string.IsNullOrEmpty(_Person.ImagePath))
                {
                    File.Delete(_Person.ImagePath);
                    return true;
                }
                return true;
            }

            if (string.IsNullOrEmpty(_Person.ImagePath))
            {
                if (pbPersonImage.ImageLocation != null)
                {
                    SourceFile = pbPersonImage.ImageLocation;
                    if (clsUtil.CopyImageToFolderImages(ref SourceFile, "E:\\CRMS_People_Images"))
                    {
                        pbPersonImage.ImageLocation = SourceFile;
                        return true;
                    }
                    return false;
                }
            }

            if (!string.IsNullOrEmpty(_Person.ImagePath))
            {
                if (_Person.ImagePath != pbPersonImage.ImageLocation)
                {
                    try
                    {
                        File.Delete(_Person.ImagePath);
                    }
                    catch (Exception)
                    {
                        return false;
                    }

                    SourceFile = pbPersonImage.ImageLocation;
                    if (clsUtil.CopyImageToFolderImages(ref SourceFile, "E:\\BMS_People_Images"))
                    {
                        pbPersonImage.ImageLocation = SourceFile;
                        return true;
                    }
                    return false;
                }
            }

            return true;
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (!this.ValidateChildren())
            {
                return;
            }

            if (!_HandlePersonImage())
                return;

            _Person.FirstName = txtFirstName.Text;
            _Person.SecondName = txtSecondName.Text;
            _Person.ThirdName = txtThirdName.Text;
            _Person.LastName = txtLastName.Text;
            _Person.NationalNo = txtNationalNo.Text;
            _Person.DateOfBirth = dtpDateOfBirth.Value;
            _Person.Gender = (rbMale.Checked ? (byte)0 : (byte)1);
            _Person.Nationality = clsCountry.Find(cbCountries.Text).CountryID;
            _Person.Email = txtEmail.Text;
            _Person.Phone = txtPhone.Text;
            _Person.Address = txtAddress.Text;
            _Person.ImagePath = (!string.IsNullOrEmpty(pbPersonImage.ImageLocation) ? pbPersonImage.ImageLocation : "");

            if (_Person.Save())
            {
                lblPersonID.Text = _Person.PersonID.ToString();
                MessageBox.Show("Saved Data Successfully", "Saved", MessageBoxButtons.OK, MessageBoxIcon.Information);
                _Mode = clsEnums.enMode.Update;
                lblTitle.Text = "Update Person";

                if (OnAddUpdatePerson != null)
                    AddUpdatePerson(_Person);

                //DataBack?.Invoke(_Person.PersonID);
            }
            else
                MessageBox.Show("Saved Data Failed", "Failed", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        private void frmAddUpdatePerson_Activated(object sender, EventArgs e) => txtFirstName.Focus();

        private void btnClose_Click(object sender, EventArgs e) => this.Close();
    }
}