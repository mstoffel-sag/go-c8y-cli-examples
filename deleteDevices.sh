#!/bin/bash
c8y util repeatfile created.json | c8y devices delete -f    
rm -f created.json
