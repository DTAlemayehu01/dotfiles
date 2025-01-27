#!/bin/bash
xdg-open http://$(ip --oneline rout get 1.1.1.1 | awk '{print $3}')
