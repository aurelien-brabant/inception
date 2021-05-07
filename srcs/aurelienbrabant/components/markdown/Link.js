import styles from "../../styles/markdown/link.module.css";

export default function Link({ href, children }) {
	return (
		<a
			className={styles.link}
			href={href}
		>
			{children}
		</a>
	);
}
