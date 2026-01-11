# Week 1 Reflections - Monday

## Permission Deep Dive

**Q: What's the difference between user/group/other permissions?**
A:

- User (owner): First rwx - person who owns the file
- Group: Second rwx - members of the file's group
- Other: Third rwx - everyone else on the system

## Real-World Implications

- 777 = Security nightmare (anyone can do anything)
- 755 = Good for executables (owner writes, others execute)
- 644 = Good for config files (owner writes, others read)
- 600 = Secrets (only owner can read/write)

## What I Learned

### Key Observations

- **SSH keys need 600 permissions** - I tried connecting to an EC2 instance and got "permissions too open" error. Had to `chmod 600 my-key.pem` before it worked.
- **Shell scripts need execute permission** - Created a backup script but couldn't run it until I did `chmod +x backup.sh`. The 755 permission makes sense now - I can execute it, others can too, but only I can modify it.
- **Log files are typically 644** - Noticed `/var/log` files are readable by everyone but only writable by root. This allows monitoring tools to read logs without security risks.

### Mistakes I Made

- **Set a config file to 777 in frustration** - My nginx config wasn't loading, so I just opened all permissions. Later realized the actual issue was the file path, not permissions. Learned to check logs first before changing permissions.
- **Forgot group permissions matter** - Spent 30 minutes debugging why I couldn't access a shared script. I had set it to 700 instead of 750, blocking group access entirely.
- **Changed permissions on the wrong directory** - Accidentally ran `chmod -R 777 /var/www` instead of just the uploads folder. Had to restore from backup and be more careful with recursive flags.

### "Aha!" Moments

- **Why cloud security groups exist** - After learning file permissions, I realized AWS security groups are basically network-level permissions. Same concept: who (which IP/user) can do what (which port/action) to which resource.
- **The principle of least privilege clicked** - When I deployed my static portfolio website to EC2, I realized I didn't need to give the web server write access to my HTML/CSS files. Setting them to 644 means nginx can read and serve them, but can't modify them even if compromised. Only I (as owner) can update the site files.
- **Permissions are the first line of defense** - Before learning about firewalls and IAM policies, basic Linux permissions are already protecting the system. It's like locking your bedroom door even though your house has a front door lock.
