import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Doctors {
  Doctors({
    required this.name,
    required this.city,
    required this.specialist,
    required this.description,
    required this.img,
    required this.fees,
  });

  final String name;
  final String img;
  final String city;
  final String specialist;
  final String description;
  final String fees;
}

class Disease {
  Disease(
      {required this.dis_name,
      required this.dis_anim,
      required this.doctors,
      required this.is_not_selected,
      required this.is_filter_added});

  final String dis_name;
  final Widget dis_anim;
  final List<Doctors> doctors;
  bool is_not_selected;
  bool is_filter_added;
}

List<Disease> diseases = [
  Disease(
      dis_name: 'Heart Issues',
      dis_anim: Row(
        children: [
          const SizedBox(
            width: 80,
          ),
          SizedBox(
            height: 82,
            width: 85,
            child: Lottie.asset('lib/animations/heart.json'),
          )
        ],
      ),
      doctors: [
        Doctors(
          name: 'Dr. Surinder Verma',
          specialist: 'Cardiologist',
          city: 'Mumbai',
          description:
              'Dr. Surinder Hansra is an experienced Consultant Cardiologist practicing in Kandivali East. He is an expert in Angiography, Angioplasty (via the Wrist) and pacemaker procedures. He is also proficient in treating High Blood Pressure & Diabetes. Dr. Hansra provides facilities of ECG, 2D Echocardiography, Ambulatory Blood Pressure Monitoring & Holter Monitoring at his clinic.',
          img: 'lib/images/heart1.png',
          fees: '800',
        ),
        Doctors(
            name: 'Dr. Swati Garekar',
            specialist: 'Cardiologist',
            city: 'Delhi',
            description:
                'Dr. Swati Garekar is American board trained Pediatric Cardiologist from the Children’s Hospital of Michigan, She is a consultant at the Fortis Child Heart Mission (FCHM) at Mulund. With years of experience and expertise, she diagnoses and manages babies and children with heart defects at FHCM. Her areas of interest are fetal echocardiography and ventricular function evaluation by echocardiography. In addition, she also has various publications to her credit',
            img: 'lib/images/heart2.png',
            fees: '850'),
        Doctors(
            name: 'Dr. Suresh Vijan',
            specialist: 'Cardiologist',
            city: 'Bangalore',
            description:
                'Dr. Suresh Vijan is a Cardiologist in Khar West, Mumbai and has an experience of 25 years in this field. Dr. Suresh Vijan practices at Vijan Heart clinic in Khar West, Mumbai. He completed MD - Medicine from Grant Medical College in 1981, FRCP from UK in 1996 and FSCAI from Society of Coronary Angiography and Intervention in 2012.',
            img: 'lib/images/heart3.png',
            fees: '900'),
        Doctors(
            name: 'Dr. Hasmukh Rao',
            specialist: 'Cardiologist',
            city: 'Chennai',
            description:
                'Dr. Hasmukh Ravat has an extensive experience of clinical and invasive cardiology. He has primary interest in coronary and peripheral angioplasty. Dr. Ravat had a privilege of learning and practicing at renowned places in Mumbai and Australia. He had exclusive training for two years in Interventional Cardiology in Australia. In last sixteen years he at Fortis Hospital he has performed more than 20000 procedures independently, more than 14000 angioplasties and deployed more than 7000 stents.',
            img: 'lib/images/heart4.png',
            fees: '950'),
        Doctors(
            name: 'Dr. Ankur Phatar',
            specialist: 'Cardiologist',
            city: 'Kolkata',
            description:
                'Dr. Ankur Ulhas Phatarpekar is a Consultant Interventional Cardiologist. He has done his MD and DM Cardiology from prestigious Seth G. S. Medical College and King Edward Memorial Hospital where he also worked as Assistant Professor. He has always been an academic achiever and topped in various competitive exams. He has conducted several interventional trials and has more than 30 international publications to his name. He is attached to several hospitals like Breach Candy, Wockhartds Hospital, Global, Fortis Raheja and Symbiosis speciality clinic. ',
            img: 'lib/images/heart5.png',
            fees: '750'),
        Doctors(
            name: 'Dr. Haresh Mehta',
            specialist: 'Cardiologist',
            city: 'Bhopal',
            description:
                'Spanning a career of over 15 years in Interventional Cardiology, Dr Haresh Mehta already has over 10000 independent interventional cases to his credit performing majority of his interventional cases from the transradial route. Dr. Haresh Mehta has trained in coronary and pediatric interventions at University Hospital Bern Switzerland and peripheral, carotid and renal interventions at the prestigious Lenox Hill Hospital, New York, which are the leading centres in the world for interventional Cardiology. ',
            img: 'lib/images/heart6.png',
            fees: '800'),
      ],
      is_not_selected: true,
      is_filter_added: false),
  Disease(
      dis_name: 'Diabetes',
      dis_anim: Row(
        children: [
          const SizedBox(
            width: 110,
          ),
          SizedBox(
            height: 90,
            width: 90,
            child: Lottie.asset('lib/animations/diab.json'),
          )
        ],
      ),
      doctors: [
        Doctors(
            name: 'Dr. Sweta Budyal',
            specialist: 'Diabetologist',
            city: 'Pune',
            description:
                'Dr. Sweta Budyal is a Endocrinologist and Diabetologist in Mulund West, Mumbai and has an experience of 12 years in these fields. Dr. Sweta Budyal practices at Fortis Hospital in Mulund West, Mumbai. She completed MBBS from Lokmanya Tilak Municipal Medical College, Sion,Mumbai in 2006,DM - Endocrinology from King Edward Memorial Hospital and Seth Gordhandas Sunderdas Medical College in 2013 and Fellowship in Bariatric Medicine from University of Ottawa, Canada in 2016.She is a member of Medical Council of India (MCI).',
            img: 'lib/images/diab1.png',
            fees: '850'),
        Doctors(
          name: 'Dr. Abhijit Jadhav',
          specialist: 'Diabetologist',
          city: 'Amritsar',
          description:
              'Dr. Abhijit Jadhav is a Diabetologist, General Endocrinologist and Consultant Physician in Mulund East, Mumbai. Dr. Abhijit Jadhav practices at Aditya Care in Mulund East, Mumbai. The doctor completed MBBS from BYL Nair Hospital Mumbai in 2000, D. Diabetology from BYL Nair Hospital Mumbai in 2006 and F.C.P.S.(Medicine) from BYL Nair Hospital Mumbai in 2007.The doctor is a member of Research Society for the Study of Diabetes in India (RSSDI) and UDF. ',
          img: 'lib/images/diab2.png',
          fees: '750',
        ),
        Doctors(
          name: 'Dr. Shobha Patil',
          specialist: 'Diabetologist',
          city: 'Srinagar',
          description:
              'Doctor is practicing at Diabetes and wellness clinic since 2013. Doctor has done graduation in MBBS from Government medical college, Nagpur, Post graduation in general medicine DNB. GEN.MED. from National Board New Delhi. Doctor has done her specialization in Diabetes from SIR.HN Hospital, Mumbai. Doctor also has done a certified course in Diabetology Steno Diabetes Centre from Denmark . She has valuable experience from All India Institute Of Diabetology in S.L. Raheja Hospital, Mahim, Mumbai',
          img: 'lib/images/diab3.png',
          fees: '700',
        ),
        Doctors(
          name: 'Dr. Salaah Qureshi',
          specialist: 'Diabetologist',
          city: 'Vadodara',
          description:
              'Specialist in Heart Disease, Diabetes, Hypertension, Infections, High Cholesterol and Critical Care, Diabetologist',
          img: 'lib/images/diab4.png',
          fees: '950',
        ),
        Doctors(
          name: 'Dr. Bhavik Saglani',
          specialist: 'Diabetologist',
          city: 'Thiruvananthapuram',
          description:
              "Dr. Bhavik Saglani is a Diabetes Health Physician working as a consultant in the department of Diabetology at Apollo Sugar Diabetes Clinics in Tardeo, Kandivali and Chembur. After completing his graduation, Dr. Saglani has gained extensive experience in the field of Diabetology and Endocrinology while working in the aforementioned departments at P.D Hinduja Hospital (Mahim) and Lilavati Hospital (Bandra) and at Dr.Panikar's Speciality Care Centre for more than 3 years.After completing his specialization in Diabetology from Lilavati Hospital.",
          img: 'lib/images/diab5.png',
          fees: '900',
        ),
        Doctors(
          name: 'Dr. Dhrumil Lad',
          specialist: 'Diabetologist',
          city: 'Nashik',
          description:
              'Dr. Dhrumil Panchal is a highly trained specialist who provides a range of medical health care to patients.He cares for difficult, unusual and general medical problems and continues to see the patient until these problems have resolved or stabilized.He treats acute and chronic illnesses and provides preventive care and health education to patients.Broadly educated to deal with the entire range of the patient’s medical problems..',
          img: 'lib/images/diab6.png',
          fees: '850',
        ),
      ],
      is_not_selected: true,
      is_filter_added: false),
  Disease(
      dis_name: 'Kidney Issues',
      dis_anim: Row(
        children: [
          const SizedBox(
            width: 80,
          ),
          SizedBox(
            height: 75,
            width: 75,
            child: Lottie.asset('lib/animations/kidney.json'),
          )
        ],
      ),
      doctors: [
        Doctors(
          name: 'Dr. Atul Ingale',
          city: 'Lucknow',
          description:
              'Dr. Atul Ingale is an consultant Nephrologist in Fortis. He has more than 20years of experience. He has completed his Master Degree from GMC ( Aurangabad ). Nephrology; Michigon (USA) recently honoured with FRCP. He has started his carrier as Jr. consultant Nephrologist & Transplant Physician at PD Hinduja Hospital in 1991. He has been Honoured to conduct 1st Dialysis, 1st Kidney transplant of Navi Mumbai. Also attached to university of mumbai as Proffessor of Medicine. Has Previlage to be included in prestigious K- DOQI & K- DIGO guidelines for Nephrology.',
          img: 'lib/images/kidney1.png',
          specialist: 'Nephrologist',
          fees: '800',
        ),
        Doctors(
          name: 'Dr. Sandip Bhurke',
          city: 'Ranchi',
          description:
              'Dr. Sandip Bhurke is a Nephrologist/Renal Specialist in Andheri West, Mumbai and has an experience of 25 years in this field. Dr. Sandip Bhurke practices at Prabhakar Bhurke Clinic in Andheri West, Mumbai. He completed DNB - Nephrology from Topiwala National Medical College & BYL Nair Charitable Hospital in 2008,MBBS from Topiwala National Medical College & BYL Nair Charitable Hospital in 1996 and MD - General Medicine from King Edward Memorial Hospital and Seth Gordhandas Sunderdas Medical College in 2002. ',
          img: 'lib/images/kidney2.png',
          specialist: 'Nephrologist',
          fees: '950',
        ),
        Doctors(
          name: 'Dr. Haresh Dodeja',
          city: 'Patna',
          description:
              'Dr. Haresh Dodeja completed his MD (med) from GMC, Mumbai and DNB Nephrology from Jaslok Hospital. He received his Royal College Fellowship in Nephrology from Leicester general hospital in 2005, with special training in renal obstetrics and long term management of transplant patients. he has done the first live related, first cadaver, and first ABOi transplant in the loco regional area of thane Mulund.',
          img: 'lib/images/kidney3.png',
          specialist: 'Nephrologist',
          fees: '750',
        ),
        Doctors(
          name: 'Dr. Amit Jain',
          city: 'Kochi',
          description:
              'Dr. Amit S Jain has completed his MBBS from the prestigious Seth G S Medical college and KEM Hospital in 2010. He accomplished his MD Medicine from Sardar Patel Medical College, Bikaner, Rajasthan in 2014. He then joined Jaslok Hospital and Research Centre for DNB NEPHROLOGY which he cleared in 2019. He has won various awards for paper presentations at state and national level conferences. He was honoured with prestigious AMAR GANDHI AWARD at Jaslok hospital in 2019.',
          img: 'lib/images/kidney4.png',
          specialist: 'Nephrologist',
          fees: '800',
        ),
        Doctors(
          name: 'Dr. Bharat Shah',
          city: 'Vizag',
          description:
              'Dr. Bharat V Shah is a Nephrologist/Renal Specialist in Parel, Mumbai and has an experience of 43 years in this field. Dr. Bharat V Shah practices at Global Hospitals in Parel, Mumbai. He completed MBBS from University Of Bombay in 1980,MD - Medicine from University Of Bombay in 1982 and DNB - Nephrology from National Board Of Examination in 1984',
          img: 'lib/images/kidney5.png',
          specialist: 'Nephrologist',
          fees: '1200',
        ),
        Doctors(
          name: 'Dr. M.R. Merchant',
          city: 'Nagpur',
          description:
              'Dr. M.R. Merchant is a Nephrologist/Renal Specialist in Mahim, Mumbai and has an experience of 44 years in this field. Dr. M.R. Merchant practices at S L Raheja Fortis Hospital in Mahim, Mumbai. He completed MBBS from SETH G.S.MEDICAL COLLEGE AND K.E.M. HOSPITAL in 1979,MD - General Medicine from King Edward Memorial Hospital and Seth Gordhandas Sunderdas Medical College in 1984 and DNB - Nephrology from King Edward Memorial Hospital and Seth Gordhandas Sunderdas Medical College in 1987.',
          img: 'lib/images/kidney6.png',
          specialist: 'Nephrologist',
          fees: '1000',
        ),
      ],
      is_not_selected: true,
      is_filter_added: false),
  Disease(
      dis_name: 'Child Specialist',
      dis_anim: Row(
        children: [
          const SizedBox(
            width: 56,
          ),
          SizedBox(
            height: 95,
            width: 75,
            child: Lottie.asset('lib/animations/child.json'),
          )
        ],
      ),
      doctors: [
        Doctors(
          name: 'Dr. Vilas Kulkarni',
          city: 'Mumbai',
          description:
              'Dr. Vilas Kulkarni has practiced at Yamuna Nagar for 28 years and has a total of 38 years of Pediatric experience. He ensures to clarify any doubt and talk to the point in a very warm friendly manner and is known for his effective diagnosis and treatments',
          img: 'lib/images/child1.png',
          specialist: 'Pediatrician',
          fees: '800',
        ),
        Doctors(
          name: 'Dr. Shilpa Nayak',
          city: 'Bangalore',
          description:
              'Dr. Shilpa Nayak is the founder of Asthma & Allergy Clinic in Andheri-W, Mumbai. She is holding MBBS, DCH, DAA (CMC Vellore) Gold Medalist and having a rich experience of 20 years, in the leading hospitals & clinics of India & abroad. She has successfully completed Diploma in Allergy and Asthma from one of the world’s most prestigious institute CMC, Vellore. This programme was conducted in collaboration with International Asthma Services USA. She was awarded Dr. Henry Claman Gold Medal from the Department of Pulmonology, CMC (Vellore). ',
          img: 'lib/images/child2.png',
          specialist: 'Pediatrician',
          fees: '950',
        ),
        Doctors(
          name: 'Dr. Yogesh Mehta',
          city: 'Chennai',
          description:
              'Dr. Yogesh Mehta has been a senior pediatric consultant for the last 37 years. He has a clinic in Ghatkopar West, Mumbai. He supports his patients through good availability on phone and video consultations. He is warm and friendly, and patiently clarifies all doubts.He has worked at Hiranandani Hospital as the Head of Department of Pediatrics for 12 years. He also worked as the unit in-charge at Rajawadi Govt. Municipal Hospital for 15 years. He has extensive experience in newborn/neonatal and infant management. ',
          img: 'lib/images/child3.png',
          specialist: 'Pediatrician',
          fees: '900',
        ),
        Doctors(
          name: 'Dr. Deepti Chawla',
          city: 'Delhi',
          description:
              "Specialist Pediatrician and neonatologist with experience of 11 years. Graduated with MD Pediatrics and completed senior residency from prestigious and India's top rated MAMC, New Delhi. Special expertise in managing Newborn, Feeding problems, vaccination, infections, developmental disorders and poor growth. Specially trained in critical care management in both pediatric and neonate patients and providing holistic care to children and parents.",
          img: 'lib/images/child4.png',
          specialist: 'Pediatrician',
          fees: '800',
        ),
        Doctors(
          name: 'Dr. Zinal',
          city: 'Lucknow',
          description:
              'Dr. Zinal is a Pediatrician in Andheri West, Mumbai and has an experience of 25 years in this field. Dr. Zinal practices at Mothers Care Clinic in Andheri West, Mumbai. He completed MBBS from King Edward Memorial Hospital and Seth Gordhandas Sunderdas Medical College in 1998,Diploma in Child Health (DCH) from School of Physiotherapy, BYL Nair hospital ,Byculla, Mumbai in 2000 and International Board Certified Lactation Consultant from IBCLC in 2009.',
          img: 'lib/images/child5.png',
          specialist: 'Pediatrician',
          fees: '750',
        ),
        Doctors(
          name: 'Dr. Vipul Mehrotra',
          city: 'Ranchi',
          description:
              'Dr. Vipul Mehrotra is a senior consultant with special interest in pediatric asthma and allergy',
          img: 'lib/images/child6.png',
          specialist: 'Pediatrician',
          fees: '950',
        ),
      ],
      is_not_selected: true,
      is_filter_added: false),
  Disease(
      dis_name: 'Dental Care',
      dis_anim: Row(
        children: [
          const SizedBox(
            width: 95,
          ),
          SizedBox(
            height: 75,
            width: 75,
            child: Lottie.asset('lib/animations/dental.json'),
          )
        ],
      ),
      doctors: [
        Doctors(
          name: 'Dr. Rajesh Shetty',
          city: 'Mumbai',
          description:
              '* Post graduate (University of Mumbai) with advanced international dental education ( from U.S..A,Brazil, Italy, South Korea & Switzerland).* 22 years of clinical experience.* Gold medalist in Dentistry from Mumbai university .* Professor & Head of Dept ; Public health dentistry .(2005 till 2014)* Clinical experience of over 1000 implants.* Clinical experience of over 100 cases of smile makeovers',
          img: 'lib/images/dental1.png',
          specialist: 'Dental Surgeon',
          fees: '900',
        ),
        Doctors(
          name: 'Dr. Sanket Mehta',
          city: 'Delhi',
          description:
              "Dr. Sanket Mehta is a Dentist, Endodontist, and Implantologist in Matunga, Mumbai and has an experience of 12 years in these fields. He completed BDS from Yerala Medical College And Hospital. in 2005, Certified Implantologist from Aspun University, Korea in 2009 and Certified Endodontic's & Pedo (USA) from the University of Pennsylvania in 2012.He is a member of Indian Dental Association, Indian Endodontic Society and Indian Society of Oral Implantologist.",
          img: 'lib/images/dental2.png',
          specialist: 'Dental Surgeon',
          fees: '850',
        ),
        Doctors(
          name: 'Dr. Sandhya B',
          city: 'Patna',
          description:
              'Dr. Sandhya is an expert in Cosmetic Dentistry, Orthodontics, and Implantology. Passionate about always enhancing her knowledge, she regularly does courses in India and abroad. Dr. Sandhya Biyani graduated from the prestigious Nair Hospital Dental College, Mumbai. After having done her graduation she worked for 3 years under the best dentists in Mumbai while advancing her knowledge by doing specialized courses in Implantology, Orthodontics, Endodontics, Cosmetic & Aesthetic Dentistry.',
          img: 'lib/images/dental3.png',
          specialist: 'Dental Surgeon',
          fees: '1200',
        ),
        Doctors(
          name: 'Dr. Ajay Thaker',
          city: 'Pune',
          description:
              'Dr. Ajay Thaker is a Dental Surgeon in Mulund West, Mumbai, Fellow Of International Congress Of Oral Implantologists, USA & has an experience of 17 years in this field. Dr. Ajay Thaker practices at "Smiles Royale" Clinic in Mulund West, Mumbai. He completed his B.D.S from S. P. Dental College, Wardha in 1997 & Internship at D. Y. Patil Dental College, Navi Mumbai.',
          img: 'lib/images/dental4.png',
          specialist: 'Dental Surgeon',
          fees: '950',
        ),
        Doctors(
          name: 'Dr. Jyoti Narla',
          city: 'Srinagar',
          description:
              'A brilliant clinician & topper in Maharashtra state at Postgraduate(MDS)and university topper in Undergraduate (BDS)levels of Dental schooling. Finished post-graduation that is Masters in Dental Surgery in the field of Periodontics & Implantology. She has done her graduation & masters from most reputed and the best dental institutes Sharad Pawar dental college and hospital, Wardha &. Govt Dental College & Hospital. She has been Ex-Professor in Dental College and an asst editor in JIDA(Journal of Indian Dental Association).',
          img: 'lib/images/dental5.png',
          specialist: 'Dental Surgeon',
          fees: '1100',
        ),
        Doctors(
          name: 'Dr. Rati Chadha',
          city: 'Amritsar',
          description:
              'Dr. Rati Chadha is a well known Prosthodontist- Cosmetic Dentist, Implantologist, Denture Specialist practicing in the heart of Bandra. Her aim is to provide the best dental care to her patients using her expertise, skills & knowledge with utmost care, comfort, and sincerity.',
          img: 'lib/images/dental6.png',
          specialist: 'Dental Surgeon',
          fees: '1000',
        ),
      ],
      is_not_selected: true,
      is_filter_added: false),
  Disease(
      dis_name: 'Homeopathy',
      dis_anim: Row(
        children: [
          const SizedBox(
            width: 81,
          ),
          SizedBox(
            height: 75,
            width: 75,
            child: Lottie.asset('lib/animations/homeo.json'),
          )
        ],
      ),
      doctors: [
        Doctors(
          name: 'Dr. P M Bhanej',
          city: 'Nagpur',
          description:
              'Dr. P M Bhanej is a Homeopath and Homeopathic Pharmacist in Malad West, Mumbai and has an experience of 45 years in these fields. Dr. P M Bhanej practices at Shri Laxmi Homeopathic Clinic in Malad West, Mumbai. He is a member of Malad Medical Association. Some of the services provided by the doctor are: Inflammatory Bowel Disease (IBD) Treatment, Diabetic Diet Counseling, Wrinkles Remedy, Child Development Disease Treatment and Skin Disease Treatment etc.',
          img: 'lib/images/hom1.png',
          specialist: 'Homeopath',
          fees: '950',
        ),
        Doctors(
          name: 'Dr. Rajesh Shah',
          city: 'Nashik',
          description:
              "Dr. Rajesh Shah, M.D(Homeopathy) practices in Mumbai, India. He has studied homeopathy intensively for over thirty years, since 1980. Dr. Rajesh is an internationally acclaimed physician, researcher, and teacher. Over the years he has conducted seminars and workshops for the practitioners and the students in England, Holland, Belgium, Czech Rep., Greece, Sweden, U.S.A., Ireland, Croatia, Norway, Japan, India, etc.Dr. Shah has an uncommon strength of having a research base in his clinical environment.",
          img: 'lib/images/hom2.png',
          specialist: 'Homeopath',
          fees: '900',
        ),
        Doctors(
          name: 'Dr. Amit Vora',
          city: 'Mumbai',
          description:
              'Dr. Amit Vora is Graduate in Homoeopathy from Mumbai in the year 2004. Started his clinic from a small room in 2004 now it has developed into 2 full fledged clinics at LBS road Bhandup & Paanchpakahadi Thane. He is a young & Dynamic doctor who has worked with many senior doctors in Mumbai on treating many serious cases with Homoeopathy. He is a regular speaker at many medical conferences & has presented articles in various Homoeopathic medical journals. He was the Course coordinator of Maharashtra University of Health Sciences (MUHS) recognized Certification & Fellowship course In Advanced Homoeopathy from 2014 to 2015. ',
          img: 'lib/images/hom3.png',
          specialist: 'Homeopath',
          fees: '850',
        ),
        Doctors(
          name: 'Dr. Hetal Pabaria',
          city: 'Delhi',
          description:
              'Dr Hetal Pabaria has been associated with Dr Batra’s as the Head of Medical Services at the Sion, Mumbai clinic. A senior homeopath, Dr Hetal has also done her Post Graduate in Homeopathy from London and a Certificate course in Mental Health Management. She has treated over 8,500 patients for several acute as well as chronic ailments with homeopathy like allergic rhinitis, asthma, hair fall, skin problems, piles, migraine, obesity, arthritis, digestive problems, and child health, among others. ',
          img: 'lib/images/hom4.png',
          specialist: 'Homeopath',
          fees: '700',
        ),
        Doctors(
          name: 'Dr. Komal Dixit',
          city: 'Lucknow',
          description:
              "Dr. Komal Dixit is a highly experienced and senior most doctor who has been practicing for more than 16 years. She holds a Bachelor of Homeopathic Medicine and Surgery (BHMS) from Bharti Vidyapeeth's Homoeopathic Medical College, Pune. She also completed MD (Homeopathy) from Y.M.T Homoepathic Medical College. Along with the specialization in Homeopathy, she pursued certificate course in Naturopathy from Bharti Vidyapeeth's Homoeopathic Medical College, Pune. She is a Gold medallist, awarded by Pranab Mukherjee award.",
          img: 'lib/images/hom5.png',
          specialist: 'Homeopath',
          fees: '750',
        ),
        Doctors(
          name: 'Dr. Amol Rane',
          city: 'Chennai',
          description:
              'One of the dynamic, cool, calm and passionate Dr. Amol Rane is a leading Homoeopath in Mumbai, India. He is also a diligent and passionate core member of Hahnemannian Homoeo Forum (HHF), which preaches and teaches homoeopathic doctors and students the final aspects of case receiving, understanding and management in homoeopathy to become a confident homoeopath.He is one of the directors of HHF Academy and Research Institute. He is committed to give the best of best treatment to his patients and help them cure their diseases. ',
          img: 'lib/images/hom6.png',
          specialist: 'Homeopath',
          fees: '700',
        ),
      ],
      is_not_selected: true,
      is_filter_added: false),
  Disease(
      dis_name: 'Cancer',
      dis_anim: Row(
        children: [
          const SizedBox(
            width: 145,
          ),
          SizedBox(
            height: 75,
            width: 75,
            child: Lottie.asset('lib/animations/cancer.json'),
          )
        ],
      ),
      doctors: [
        Doctors(
          name: 'Dr. Uma Dangi',
          city: 'Bhopal',
          description:
              'Dr. Uma Bhaskar Dangi is one of the best Medical Oncologist in , Mumbai. She is currently attached to Fortis Hospital at Mulund. Dr Uma Dangi is an oncologist with almost a decade of experience in Medical Oncology. Dr Uma Bhaskar Dangi did her undergraduate studies at Grant Medical College, Mumbai and then completed her DNB in Internal Medicine from Dr. R. N. Cooper Municipal General Hospital.',
          img: 'lib/images/canc1.png',
          specialist: 'Oncologist',
          fees: '800',
        ),
        Doctors(
          name: 'Dr. Smit Sheth',
          city: 'Vadodara',
          description:
              'Dr. Smit Sheth is a Medical Oncologist in Mulund, Mumbai and has an experience of 14 years in this field. Dr. Smit Sheth practices at Mumbai Oncocare Centre in Mulund, Mumbai. He completed MBBS from Terna Medical College and Hospital, Navi Mumbai in 2007,MD - Medicine from Medical College, Baroda in 2015 and DM - Medical Oncology from Homi Bhaba National Institute in 2018.',
          img: 'lib/images/canc2.png',
          specialist: 'Oncologist',
          fees: '850',
        ),
        Doctors(
          name: 'Dr. Akshay Shah',
          city: 'Pune',
          description:
              'Dr. Akshay Shah received his certification in Medical Oncology and completed his fellowship in Stem Cell Transplantation from Washington, Seattle. His areas of interest include paediatric and haemato-oncology.',
          img: 'lib/images/canc3.png',
          specialist: 'Oncologist',
          fees: '950',
        ),
        Doctors(
          name: 'Dr. Amol Akhade',
          city: 'Nashik',
          description:
              'An alumnus from the prestigious Tata Memorial Hospital, Dr.Amol Akhade, senior medical hemat-oncologist, has studied from Mumbai’s topmost Government medical colleges. His distinguished academic qualifications coupled with extensive experience in treating cancer of all kinds has been a boon for thousands of cancer patients, whom he has treated successfully over the years. His special interests lie in Chemotherapy for all cancers, blood cancers, bone marrow transplant, targeted therapy, immune therapy, biopsy, bone marrow aspiration, etc.  ',
          img: 'lib/images/canc4.png',
          specialist: 'Oncologist',
          fees: '1000',
        ),
        Doctors(
          name: 'Dr. Suresh Advani',
          city: 'Nagpur',
          description:
              'He has a special interest in Medical Oncology/Hematology and the medical interactions with other clinical branches and basic sciences. He is very interested in the field of developmental therapeutics and clinical research. This has integrated projects involving all the branches of clinical oncology as well as basic research. He also has an interest in biological therapeutics targeting various molecular targets on the cancer cells. He has been the pioneer in establishing Bone Marrow Transplantation in India. ',
          img: 'lib/images/canc5.png',
          specialist: 'Oncologist',
          fees: '800',
        ),
        Doctors(
          name: 'Dr. Boman Dhabar',
          city: 'Lucknow',
          description:
              'Dr. Boman Dhabar is Working as a consultant Medical Oncologist since 1994, Dr. Dhabar has years of experience and skill. He completed his basic training in Medical Oncology from the Tata Memorial Hospital, which included managing immune - compromised patients, inserting and care of central venous lines, administration of chemotherapeutic agents for haematological and solid tumours as well as managing their toxicities. Dr Dhabar has also published numerous journals, both nationally and internationally.',
          img: 'lib/images/canc6.png',
          specialist: 'Oncologist',
          fees: '700',
        ),
      ],
      is_not_selected: true,
      is_filter_added: false),
  Disease(
      dis_name: 'Eye Specialist',
      dis_anim: Row(
        children: [
          const SizedBox(
            width: 75,
          ),
          SizedBox(
            height: 75,
            width: 75,
            child: Lottie.asset('lib/animations/eye.json'),
          )
        ],
      ),
      doctors: [
        Doctors(
          name: 'Dr. Sachin Shah',
          city: 'Mumbai',
          description:
              "Dr. Sachin V Shah is a Ophthalmologist/ Eye Surgeon in Mulund East, Mumbai and has an experience of 24 years in this field. Dr. Sachin V Shah practices at Practo Care Surgeries in Mulund East, Mumbai and Vin-R Eye Care Centre in Vikhroli East, Mumbai. He completed MBBS from KIMS,Maharastra in 1996 and MS - Ophthalmology from Dr. V. M. Government Medical College, Solapur in 1999.Some of the services provided by the doctor are: Sonomed 'A' Scan,Astigmatism,Vitreoretinal Surgery,Vision Therapy and keratoplasty etc. ",
          img: 'lib/images/eye1.png',
          specialist: 'Ophthalmologist',
          fees: '950',
        ),
        Doctors(
          name: 'Dr. Prachi Parmar',
          city: 'Pune',
          description:
              'Dr. Prachi Parmar is a Ophthalmologist/ Eye Surgeon in Ghatkopar West, Mumbai and has an experience of 6 years in this field. Dr. Prachi Parmar practices at Ruby Eye Care Hospital in Ghatkopar West, Mumbai. She completed MBBS from B.J. Medical College, Ahmedabad (Gujarat University) in 2010, DOMS from Manipal Academy Of Higher Education, Manipal, India in 2013, and DNB - Ophthalmology from Diplomate of National Board, New Delhi in 2015. ',
          img: 'lib/images/eye2.png',
          specialist: 'Ophthalmologist',
          fees: '750',
        ),
        Doctors(
          name: 'Dr. Pooja Ghodke',
          city: 'Srinagar',
          description:
              "Dr.Pooja Ghodke completed her MBBS from prestigious Government Medical College, Nagpur, Maharashtra (MUHS). She further completed her Master's degree in Ophthalmology (M.S.Ophth) from Government Medical College, Nagpur, Maharashtra (MUHS), and earned a GOLD MEDAL for securing Rank 1 in entire Maharashtra state. She further served her Government Bond at Municipal Eye Hospital which is the only BMC-run hospital exclusively for Eye care.  ",
          img: 'lib/images/eye3.png',
          specialist: 'Ophthalmologist',
          fees: '850',
        ),
        Doctors(
          name: 'Dr. Minali Goyal',
          city: 'Amritsar',
          description:
              'Personalised modern eye set up for all anterior segment work',
          img: 'lib/images/eye4.png',
          specialist: 'Ophthalmologist',
          fees: '800',
        ),
        Doctors(
          name: 'Dr. Rajesh Mishra',
          city: 'Bhopal',
          description:
              'Dr. Rajesh Mishra is renowned Glaucoma & Phaco - Refractive Surgeon. He is attached with various premium institutes of Mumbai.He has completed the Post graduation (M.S.,Ophthalmology) from Renowned Calcutta Medical College (Regional Institute of Ophthalmology, Kolkata).He is accomplished Surgeon,done fellowship from Aravind Eye Care.Dr.Rajesh has done more than 20,000 surgeries.After successfully completing the fellowship,he was attached with The Eye Foundation and Sankara Eye Care as Senior Consultant.',
          img: 'lib/images/eye5.png',
          specialist: 'Ophthalmologist',
          fees: '900',
        ),
        Doctors(
          name: 'Dr. P Suresh',
          city: 'Kolkata',
          description:
              'Dr. P Suresh is an ophthalmic Surgeon at Fortis Hospitals. He has extensive experience in sutureless cataract surgery performing over 10000 operations. In addition he has vast experience in corneal transplantation procedure and Laser refractive surgery(LASIK)',
          img: 'lib/images/eye6.png',
          specialist: 'Ophthalmologist',
          fees: '800',
        ),
      ],
      is_not_selected: true,
      is_filter_added: false),
  Disease(
      dis_name: 'Diet And Nutrition',
      dis_anim: Row(
        children: [
          const SizedBox(
            width: 25,
          ),
          SizedBox(
            height: 90,
            width: 75,
            child: Lottie.asset('lib/animations/diet.json'),
          )
        ],
      ),
      doctors: [
        Doctors(
          name: 'Ms. Geetanjali',
          city: 'Pune',
          description:
              "Registered Dietician and Clinical Nutritionist Geetanjali Ahuja (Mengi) has been running her clinics in Bandra, Santacruz, Dadar,Mahalaxmi, Kemp's corner, Charni Road under the name of Geetanjali Medical Nutrition Clinic for last 15+ Years.Over and above personal consultations at her clinics, She also provides a wonderful medium to avail our services from the comfort of your home. ",
          img: 'lib/images/diet1.png',
          specialist: 'Nutritionist',
          fees: '750',
        ),
        Doctors(
          name: 'Ms. Bijal Furia',
          city: 'Lucknow',
          description:
              'Ms. Bijal Furia believes in a healthy lifestyle modification which is sustainable , customized and gets easily fit into your routine by understanding your body type, daily routine, food preferences, allergies, and any other specification.',
          img: 'lib/images/diet2.png',
          specialist: 'Nutritionist',
          fees: '800',
        ),
        Doctors(
          name: 'Ms. Aarti',
          city: 'Delhi',
          description:
              "Ms. Aarti is a Dietitian/Nutritionist, collective power nutritionist and pediatric parenteral and enteral nutritionist in Andheri East, Mumbai and has an experience of 5 years in these fields. Ms. Aarti practices at Global Homoeopathy & Esthetiques Clinic in Andheri East, Mumbai. She completed B.Sc.- Dietitics / Nutrition from SNDT Women's University, Mumbai in 2012.etc.",
          img: 'lib/images/diet3.png',
          specialist: 'Nutritionist',
          fees: '700',
        ),
        Doctors(
          name: 'Ms. Bansi Mehta',
          city: 'Bangalore',
          description:
              'Ms. Bansi Mehta is a Dietitian/Nutritionist in Khar West, Mumbai and has an experience of 9 years in this field. Ms. Bansi Mehta practices at Healthspring Clinic in Khar West, Mumbai and Healthspring Clinic in Oshiwara, Mumbai. She completed P.G in Sports Science Fitness & Nutrition from Shreemati Nathibai Thackersey Damodar Womens University in 2014. Some of the services provided by the doctor are: Hypertension Diet Counselling,Sports nutrition,High Cholesterol Diet Counselling,Coaching for Weight Loss and Weight Loss Diet Counseling etc. ',
          img: 'lib/images/diet4.png',
          specialist: 'Nutritionist',
          fees: '1000',
        ),
        Doctors(
          name: 'Ms. Neha Ranglani',
          city: 'Chennai',
          description:
              'Neha ranglani is an Integrative nutritionist and health coach pracitising for the last 14 years and has helped 20000+ people acroos the globe to become health independant and take charge of thier own health. She believes our body has this innate ability to heal itself provided its fed with the right raw materials in terms of food, thoughs, emotions and actions. She helps people reverse or manage obesity, diabates, thyroid, PCOS, infertility and any other issue in most natural way possible. ',
          img: 'lib/images/diet5.png',
          specialist: 'Nutritionist',
          fees: '950',
        ),
        Doctors(
          name: 'Ms. Richa Doshi',
          city: 'Mumbai',
          description:
              'Mrs. Richa Doshi, is a Consulting Nutrition expert with 9 years of experience and runs a private practice under the name "THE HEALTH STUDIO BY RICHA DOSHI". She is also a Certified Diabetes Educator along with Weight Management Specialist. Her agenda is to improve wellness through practical and sustainable lifestyle modification holistically via nutrition and exercise plans. They make nutrition science understandable, practical, realistic and oh so delicious!.',
          img: 'lib/images/diet6.png',
          specialist: 'Nutritionist',
          fees: '900',
        ),
      ],
      is_not_selected: true,
      is_filter_added: false),
];
