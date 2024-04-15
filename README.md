# Farmable

<img src="./gixLOGO.png" alt="GIX LOGO" height="100">
<img src="./MicrosoftLOGO.jpg" alt="Microsoft LOGO" height="50">

Farmable is a capstone project developed in collaboration between the University of Washington Global Innovation Exchange (UW GIX) and Microsoft Farmable Team. This project aims to bridge the gap between farmers and farm-to-table restaurants while providing traceability and sustainability information to customers. By facilitating workflows and enhancing communication, Farmable seeks to revolutionize the way food is sourced, managed, and enjoyed.

## Problem Statement
- Current farm & farm to table restaurant communications are solely through paper notes and phone calls
- Farm to table restaurant owners head to farmer's market early in the morning to source fresh ingredients
- Farmers rarely get feedback from restaurant owners or restaurant diners
- Restaurant customers does not know what kind of food they are getting, even when they wanted to

## Demo Video

[![Farmable App Demo](http://img.youtube.com/vi/M43Ag07djO4/0.jpg)](https://youtu.be/M43Ag07djO4)

## Features

### Order Management
- Request and track orders seamlessly
- Maintain records of transactions for both farmers and restaurants
- Utilize QR codes to streamline the ordering process

### Menu Management
- View and manage the dishes available at restaurants
- Ensure accurate representation of offerings through digital menus

### Digital Menu for Customers
- Access traceability and sustainability information sourced directly from farmers and restaurants
- Provide feedback to farmers and restaurants to enhance the overall experience

## Future Features

### Digital Farmer's MarketPlace
- To better aid restaurants and farmers to source produce easily based on preferred farming practices, produce type and freshness
- ⚠️ One of the feedback from user interview stated they would rather not see prices of the produces to prevent farmers worry too much about prices

### Digital logbook for farmers
- Integrate sensors and QR codes to reduce workload in uploading crop updates
- Have farmers record their farming practices on a regular basis (eg. watered amount, fertilizer use, organic practices, soil pH level)
    - This can serve as a proof rather than having farmers pay for expensive organic certifications

### Farmer's Community
- Based on information uploaded to farmer's logbook, Farmable can provide farm tailored business suggestions
- This could also be a good way for farmers new to the region to learn more about farming practices

⚠️ Check [Microsoft Farmvibes AI](https://www.microsoft.com/en-us/research/project/project-farmvibes/articles/farmvibes-ai/) to see AI features they provide (eg. crop yield prediction, soil pH level based on aerial image, vegetation greeness, etc)


## Getting Started

To get started with Farmable, follow these steps:

1. Clone the repository to your local machine.
2. Install the necessary dependencies.
3. Set up the database according to the provided schema.
4. Configure any environment variables required for your setup.
5. Start running the backend server with command `mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Dserver.address=0.0.0.0"` in the `backend` directory.
6. Run the React web frontend in `website` directory or mobile app frontend in the `mobile` directory with XCode.


## Contributing

We welcome contributions from the community to further enhance Farmable. If you're interested in contributing, please follow these guidelines:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and ensure all tests pass.
4. Submit a pull request detailing your changes.

## Support

If you encounter any issues or have any questions about Farmable, please don't hesitate to reach out to us:

- Email: [heejuk.dev@gmail.com](mailto:heejuk.dev@gmail.com)
- GitHub Issues: [Farmable Issues](link_to_github_issues)

<!-- ## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. -->

---

Thank you for your interest in Farmable! Together, let's revolutionize the way we connect farmers, restaurants, and consumers.
