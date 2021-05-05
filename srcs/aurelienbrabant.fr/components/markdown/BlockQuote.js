import styles from "../../styles/markdown/blockquote.module.css";

export default function BlockQuote({ children }) {
	return (
		<blockquote
			className={styles.blockquote}
		>
			{children}
		</blockquote>
	);
}
