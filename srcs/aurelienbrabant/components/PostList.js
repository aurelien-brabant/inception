import { Fragment, useState } from "react";

import styles from "../styles/postlist.module.css";

export default function PostList() {
	const [ searchVal, setSearchVal ] = useState("");
	const [ posts, setPosts ] = useState([]);

	/* form handlers */
	const handleChange = (event) => {
		setSearchVal(event.target.value);
	}

	return (
			<div className={styles.wrapper}>
				<div className={styles.barWrapper}>
					<input 
						type="text"
						placeholder="Rechercher" 
						onChange={handleChange}
						value={searchVal}
					/>
				</div>
				{/*<i className="fa fa-search" />*/}
			</div>
	);
}
