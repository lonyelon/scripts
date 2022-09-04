#!/bin/sh

# Notmuch does this but faster, to be deleted.

for a in ~/.local/share/mail/*; do
    ls $a/INBOX/new;
done | wc -l
