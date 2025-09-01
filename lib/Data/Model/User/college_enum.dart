enum College {
  a6BusinessAdministration('A6 - College of Business Administration'),
  a3Science('A3 - College of Science'),
  noCodeEducationAndHumanDevelopment(
    'College of Education and Human Development',
  ),
  a3ComputerAndInformationSystems(
    'A3 - College of Computer and Information Systems',
  ),
  a1Medicine('A1 - College of Medicine'),
  a2Pharmacy('A2 - College of Pharmacy'),
  a2Dentistry('A2 - College of Dentistry'),
  a10Law('A10 - College of Law'),
  a5Languages('A5 - College of Languages'),
  a8Engineering('A8 - College of Engineering'),
  a8ArtsAndDesigns('A8 - College of Arts and Designs');

  final String label;

  const College(this.label);
}
