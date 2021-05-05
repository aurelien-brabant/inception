import PropTypes from "prop-types";

import styles from "../styles/container.module.css";

export default function Container({ pageHeight, size, children }) {
	return (
		<div
			className={`${styles.container} ${styles[size]} ${pageHeight ? styles.pageHeight : ""}`}
		>
			{children}
		</div>
	)
}

Container.propTypes = {
	pageHeight: PropTypes.bool.isRequired,
	size: PropTypes.string.isRequired,
}

Container.defaultProps = {
	pageHeight: false,
	size: "md",
}
