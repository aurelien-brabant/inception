import styles from "../styles/socials.module.css";

/* Renders the social media buttons on the page */

const socialMedias = [
	{
		href: "https://github.com/aurelien-brabant",
		ficon: "fa fa-github-alt",
		color: "#000000",
		id: 0,
	},
	{
		href: "https://www.linkedin.com/in/aurelien-brabant",
		ficon: "fa fa-linkedin",
		color: "#0a66C2",
		id: 1,
	}
]

export default function Socials() {
	return (
		<div
			className={styles.socialsWrapper}
		>
			{socialMedias.map((item) => (
				<a 
					key={item.id}
					href={item.href}>
					<i 
						className={`${item.ficon}`}
						style={{color: item.color}}
					/>
				</a>
				)
			)}
		</div>
	);
}
