import Head from "next/head";

import Header from "./Header";
import Footer from "./Footer";
import Container from "./Container";

export default function Layout(props) {
	return (
		<>
			<Head>
				<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png" />
				<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png" />
				<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png" />
				<link rel="manifest" href="/site.webmanifest" />
				<link rel="mask-icon" href="/safari-pinned-tab.svg" color="#5bbad5" />
				<meta name="theme-color" content="#ffffff" />
				<link
					rel="preload"
					href="/fonts/roboto/Roboto-Regular.ttf"
					as="font"
					crossOrigin=""
				/>
				<link
					rel="preload"
					href="/fonts/jetbrains/static/JetBrainsMono-Regular.ttf"
					as="font"
					crossOrigin=""
				/>
				<link 
					href="https://fonts.googleapis.com/icon?family=Material+Icons"
      				rel="stylesheet"
				/>
				<link
					href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
					rel="stylesheet"
				/>
			</Head>
			<Header />
			{props.children}
			<Footer />
		</>	
	)
}
