import React, { Component } from 'react';

class Nav extends Component {
  
  render() {
    return (
      <div>
        <nav className="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
          <a
            className="navbar-brand col-sm-3 col-md-2 mr-0"
            href="http://www.dappuniversity.com/bootcamp"
            target="_blank"
            rel="noopener noreferrer"
          >
            Blockchain Test App
          </a>
        </nav>
        <p>
          {this.props.account}
        </p>
      </div>
    );
  }
}

export default Nav;
