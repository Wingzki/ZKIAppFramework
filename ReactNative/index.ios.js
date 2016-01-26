/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
    Text,
    View,
    Image,
} = React;

var styles = React.StyleSheet.create({
                                     container: {
                                     flex: 1,
                                     backgroundColor: 'gray'
                                     }
                                     });

class SimpleApp extends React.Component {
    render() {
        return (
                <View style={styles.container}>
                <Text>This is a simple application.</Text>
                </View>
                )
    }
}

React.AppRegistry.registerComponent('SimpleApp', () => SimpleApp);
