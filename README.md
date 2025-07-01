# 🩺 DocFusion

**DocFusion** is a cross-platform health application built using Flutter that enables seamless interaction between patients and doctors. It supports real-time appointment booking, doctor discovery, instant messaging, and secure video/audio calling — all in one clean and modern interface.

---

## 🚀 Inspiration

In today’s world, access to quality healthcare still remains a challenge — especially in remote areas or during emergencies. Traditional appointment systems are outdated, and there's a lack of fast, secure communication between doctors and patients.  
**DocFusion** was created to solve this gap through technology.

---

## 🧩 Features

- 🔍 Search doctors by specialization
- 📅 Book appointments in real time
- 📞 Secure audio/video consultation
- 💬 Instant real-time messaging
- 👥 Role-based login (Doctor & Patient)
- 🔐 Firebase Authentication & Firestore integration
- 🔔 Notification system (FCM)

---

## 🧱 Tech Stack

- **Flutter** – For cross-platform development (Android & iOS)
- **Firebase Authentication** – User management
- **Cloudinary** – Data Storage
- **Cloud Firestore** – Real-time database
- **Firebase Cloud Messaging (FCM)** – Push notifications
- **Agora/WebRTC** – Real-time audio/video calling
- **Provider** – State management
- **Android Studio** – Primary development environment

---

## 📸 Screenshots

![IMG-20250701-WA0006](https://github.com/user-attachments/assets/4d89ea33-5279-43d1-8198-848aa730a3ff)
![IMG-20250701-WA0005](https://github.com/user-attachments/assets/e44154e2-d9cd-4b4c-9472-1c34ca063a0b)
![IMG-20250701-WA0008](https://github.com/user-attachments/assets/3940578e-fdaa-487d-9da7-4af7c795b5fa)
![IMG-20250701-WA0007](https://github.com/user-attachments/assets/1280d6e2-9f97-4fca-878f-08c3a48bc98c)
![IMG-20250701-WA0011](https://github.com/user-attachments/assets/441f943d-e25f-483a-ba90-c5a87a6122dd)
![IMG-20250701-WA0010](https://github.com/user-attachments/assets/f208a39a-b0e0-4408-89b7-f0d24db9d194)
![IMG-20250701-WA0009](https://github.com/user-attachments/assets/3e64935a-86d0-4777-aef7-70443661b6fd)
![IMG-20250701-WA0012](https://github.com/user-attachments/assets/155f41fd-33b6-4fa7-84fa-f14a514ea678)

---

## 🧠 What I Learned

- Implementing scalable UI using Flutter
- Managing role-based navigation and access
- Real-time communication using Firebase and external SDKs
- Handling cross-platform consistency and secure data access

---

## 🚧 Challenges Faced

- Separating workflows for doctors and patients without duplicating code
- Configuring Firestore rules for secure role-based data access
- Ensuring smooth video call experience across platforms
- Maintaining chat sync and latency under varying network conditions

---

## 🔮 Future Scope

- AI-based doctor recommendations
- Health records management
- Online payments and billing
- Multi-language support and accessibility features

---

## 📂 Folder Structure

```
lib/
├── models/
├── screens/
│   ├── doctor/
│   ├── patient/
├── services/
├── utils/
├── widgets/
├── main.dart
```

---

## 🛠 Setup & Installation

```bash
git clone https://github.com/yashendra767/DucFusion.git
cd DucFusion
flutter pub get
flutter run
```

> Make sure to configure your Firebase project and add the required `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) in the respective directories.

---

## 📬 Contact

**KunalBansal**  
📧 kunalbansal2030@gmail.com 
🔗 [GitHub](https://github.com/Kunal-3004)  
🔗 [Project Repository](https://github.com/Kunal-3004/DocFusion)

---

> Built with ❤️ using Flutter and Firebase
