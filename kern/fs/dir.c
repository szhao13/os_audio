#include <kern/lib/types.h>
#include <kern/lib/debug.h>
#include <kern/lib/string.h>
#include "inode.h"
#include "dir.h"

// Directories

int
dir_namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
}

/**
 * Look for a directory entry in a directory.
 * If found, set *poff to byte offset of entry.
 */
struct inode*
dir_lookup(struct inode *dp, char *name, uint32_t *poff)
{
  uint32_t off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    KERN_PANIC("dir_lookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(inode_read(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      KERN_PANIC("dir_link read");
    if(de.inum == 0)
      continue;
    if(dir_namecmp(name, de.name) == 0){
      // entry matches path element
      if(poff)
        *poff = off;
      inum = de.inum;
      return inode_get(dp->dev, inum);
    }
  }

  return 0;
}

// Write a new directory entry (name, inum) into the directory dp.
int
dir_link(struct inode *dp, char *name, uint32_t inum)
{
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dir_lookup(dp, name, 0)) != 0){
    inode_put(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(inode_read(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      KERN_PANIC("dir_link read");
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(inode_write(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    KERN_PANIC("dir_link");
  
  return 0;
}
