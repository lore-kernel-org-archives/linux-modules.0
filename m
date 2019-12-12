Return-Path: <SRS0=5GNU=2C=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EA9C43603
	for <linux-modules@archiver.kernel.org>; Thu, 12 Dec 2019 19:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0562073B
	for <linux-modules@archiver.kernel.org>; Thu, 12 Dec 2019 19:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wqq+8kwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfLLTQb (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:16:31 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:42092 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbfLLTQb (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 12 Dec 2019 14:16:31 -0500
Received: by mail-il1-f169.google.com with SMTP id a6so513250ili.9
        for <linux-modules@vger.kernel.org>; Thu, 12 Dec 2019 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+BqfmujyKVamEBn2zWVGDyeZXd72ocCgg9lVEZCzOkM=;
        b=Wqq+8kwvCzo85NtkzGU58cB9mwwEulVy+v0DwY8mw1FtxszUMB6PjvNxw5bZF2VNzY
         PC/ITM8I/g8udM1g9O67gtUWqYYSuB4e7v01yeiZYaETr+HnzpXKGQyAMws9IXqc0/Ch
         kQb/tI3K4ZRL6SXj0qGUkNoUEm9Aoc+wj17bWI4HSseR5WTMfTxKqaMq9lamBE1e5mju
         h+TyKO2QfZkT3ZsviA9VIElaS2WHPl79DyMr2ejrZgSQaSxv2J5M7+p9japFtIXg7K07
         0XpqakoqhwEVSl7LKOGDYGlcF+i9bWH4nHPnBUCd2REc56wOh1ye2UHQI9tMPXFD6pjb
         Apiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+BqfmujyKVamEBn2zWVGDyeZXd72ocCgg9lVEZCzOkM=;
        b=asj1sw9bzsdnV+rrRs7m7Uf5mL0psnvLmUBObyUWxgq6BGYux3+nKM0qEA68Bx4Nb9
         aoMJ1dRO81k1w5vvvl3Bp9QkAt4TEK61z9aeZqCsd3QxSfM7Fw1vYyoPDmwAS+zZ2qdV
         atzo0nhJcfO+t5WghfISibOEg+niFfwRdwychjZL73BSzAN1yPxZaXchjGRlnpHk43IQ
         stYBj+tYdUHbkZ7m/T9twnX+uV+HXciJY1m5i1/3CT7MSrwwvv7jlJ1HSw3Eu6KQioOV
         b18uLCvTmVVuPhZLJRoVPH9v1PX5odFUjSL/13p1ZJ2nD5qk9a9C1LLwLNjLbr7mXsXj
         8HNQ==
X-Gm-Message-State: APjAAAX0i5wyC/textViiBBOIPtgg6fgEsFDxR0fMXGRx7t160xf7H1M
        DrKKZe5fdwXktj9OiGJfr7xhoWGcdwIQf3bBBIw30Jq/VsY=
X-Google-Smtp-Source: APXvYqz7uD5BevVyciBXhez9kibSnQJ+er8Z+BNRqZ0/k+D5V1KE6qgDfZAvFYadc5Zxsvv7Ux2iTX64UqldtYiRIRk=
X-Received: by 2002:a92:1d1b:: with SMTP id d27mr9869244ild.118.1576178189758;
 Thu, 12 Dec 2019 11:16:29 -0800 (PST)
MIME-Version: 1.0
From:   Jorge Lucangeli Obes <jorgelo@google.com>
Date:   Thu, 12 Dec 2019 14:16:18 -0500
Message-ID: <CAKYuF5QhGCPCazHQjN-=kFc5kHs7Ok8WqmmGLo31CiOEN8TYdA@mail.gmail.com>
Subject: Buffer overflow in modprobe
To:     linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi linux-modules@,

Chrome OS received a report of a buffer overflow in modprobe a few
weeks ago. We never got around to sending it upstream, so here it
goes.

A buffer overflow in modprobe is not very useful in cases in which
full root privileges are required to run modprobe itself. On Chrome OS
this was relevant as a persistence vector since modprobe was being
called with attacker-influenceable parameters on boot.

Cheers,
Jorge

=====
Modprobe versions, across a relatively large period include a heap
based buffer overflow in their parsing of the pre and post options to
the softdep statements.

The following file is sufficient to trigger the bug:

00000000  73 6f 66 74 64 65 70 20  30 20 20 70 6f 73 74 3a  |softdep 0
 post:| 00000010  20 30 0b                                          |
0.|
00000013

Here both the double space and some kind of space at the end of the
line are needed to trigger the bug. This bug is quite controllable, we
can control both length and content. For example we can overflow 32
bytes of content using:

00000000  73 6f 66 74 64 65 70 20  30 20 20 70 6f 73 74 3a  |softdep 0
 post:| 00000010  20 41 41 41 41 41 41 41  41 41 41 41 41 41 41 41  |
AAAAAAAAAAAAAAA| 00000020  41 41 41 41 41 41 41 41  41 41 41 41 41 41
41 41  |AAAAAAAAAAAAAAAA| 00000030  41 20 0a
               |A .| 00000033


The only constraints imposed on our content are that we can't write
null bytes, or bytes for which isspace(c) is true directly through
this overflow.

The bug is located in kmod/libkmod/libkmod-config.c where the function
kmod_config_add_softdep attempts to populate the following structure:

    47  struct kmod_softdep {
    48          char *name;
    49          const char **pre;
    50          const char **post;
    51          unsigned int n_pre;
    52          unsigned int n_post;
    53  };

In particular this is attempted with a single call to malloc, making
two iterations over the line of the config file itself. On the first
pass the function calculates the total size of allocation needed for
the struct itself, both string arrays and all the actual string bytes.
On the second pass the contents of these arrays are are then copied
and populated. The bug however is caused by the ability to induce a
mis-match between these two loops.

   207  static int kmod_config_add_softdep(struct kmod_config *config,
   208                                                          const
char *modname,
   209                                                          const
char *line)
   210  {
   211          struct kmod_list *list;
   212          struct kmod_softdep *dep;
   213          const char *s ,*p;
   214          char *itr;
   215          unsigned int n_pre = 0 ,n_post = 0;
   216          size_t modnamelen = strlen(modname) + 1;
   217          size_t buflen = 0;
[0]218          bool was_space = false;
   219          enum { S_NONE ,S_PRE ,S_POST } mode = S_NONE;
   220          DBG(config->ctx ,"modname=%s\n" ,modname);
   221          /* analyze and count */
   222          for (p = s = line; ; s++) {
   223                  size_t plen;
   224                  if (*s != '\0') {
[1]225                          if (!isspace(*s)) {
   226                                  was_space = false;
   227                                  continue;
[2]228                          }
   229                          if (was_space) {
   230                                  p = s + 1;
   231                                  continue;
[3]232                          }
   233                          was_space = true;
   234                          if (p >= s)
   235                                  continue;
   236                  }
   237                  plen = s - p;
   238                  if (plen == sizeof("pre:") - 1 &&
   239                                  memcmp(p ,"pre:"
,sizeof("pre:") - 1) == 0)
   240                          mode = S_PRE;
[4]241                  else if (plen == sizeof("post:") - 1 &&
   242                                  memcmp(p ,"post:"
,sizeof("post:") - 1) == 0)
   243                          mode = S_POST;
   244                  else if (*s != '\0' || (*s == '\0' && !was_space)) {
   245                          if (mode == S_PRE) {
   246                                  buflen += plen + 1;
   247                                  n_pre++;
   248                          } else if (mode == S_POST) {
   249                                  buflen += plen + 1;
   250                                  n_post++;
   251                          }
   252                  }
   253                  p = s + 1;
   254                  if (*s == '\0')
   255                          break;
   256          }
   258          DBG(config->ctx ,"%u pre ,%u post\n" ,n_pre ,n_post);
[5]259          dep = malloc(sizeof(struct kmod_softdep) + modnamelen +
   260                       n_pre * sizeof(const char *) +
   261                       n_post * sizeof(const char *) +
   262                       buflen);
   264          if (dep == NULL) {
   265                  ERR(config->ctx ,"out-of-memory modname=%s\n" ,modname);
   266                  return -ENOMEM;
   267          }
   268          dep->n_pre = n_pre;
   269          dep->n_post = n_post;
   270          dep->pre = (const char **)((char *)dep + sizeof(struct
kmod_softdep));
   271          dep->post = dep->pre + n_pre;
   272          dep->name = (char *)(dep->post + n_post);
   273          memcpy(dep->name ,modname ,modnamelen);
   274          /* copy strings */
   275          itr = dep->name + modnamelen;
   276       n_pre = 0;
   277          n_post = 0;
   278          mode = S_NONE;
   279          for (p = s = line; ; s++) {
   280                  size_t plen;
   281                  if (*s != '\0') {
   282                          if (!isspace(*s)) {
   283                                  was_space = false;
   284                                  continue;
   285                          }
[6]286                          if (was_space) {
   287                                  p = s + 1;
   288                                  continue;
   289                          }
   290                          was_space = true;
   291                          if (p >= s)
   292                                  continue;
   293                  }
   294                  plen = s - p;
   295                  if (plen == sizeof("pre:") - 1 &&
   296                                  memcmp(p ,"pre:"
,sizeof("pre:") - 1) == 0)
   297                          mode = S_PRE;
[7]298                  else if (plen == sizeof("post:") - 1 &&
   299                                  memcmp(p ,"post:"
,sizeof("post:") - 1) == 0)
   300                          mode = S_POST;
   301                  else if (*s != '\0' || (*s == '\0' && !was_space)) {
   302                          if (mode == S_PRE) {
   303                                  dep->pre[n_pre] = itr;
   304                                  memcpy(itr ,p ,plen);
   305                                  itr[plen] = '\0';
   306                                  itr += plen + 1;
   307                                  n_pre++;
   308                          } else if (mode == S_POST) {
   309                            dep->post[n_post] = itr;
[8]311                                  memcpy(itr ,p ,plen);
   312                                  itr[plen] = '\0';
   313                                  itr += plen + 1;
   314                                  n_post++;
   315                          }
   316                  }
   317                  p = s + 1;
   318                  if (*s == '\0')
   319                          break;
   320          }
   321          list = kmod_list_append(config->softdeps ,dep);
   322          if (list == NULL) {
   323                  free(dep);
   324                  return -ENOMEM;
   325          }
   326          config->softdeps = list;
   328          return 0;
   329  }

When we enter the function, line will be set to the string "
post:....", because of the double space in the input line.

[0] was_space is initalised to false.

[1] isspace(*s) is true. Since was_space isn't set to true [3] until
after the modification of p to advance it at [2] this doesn't happen
on the first pass around the line, so p will continue to start with a
space.

[4] plen will not match the expected length for the string "post:"
because there's an extra space. So the loop here doesn't count the
post softdeps in the 'analyse and count' pass, any bytes we have here
won't be counted inside the malloc call. The final space at the end of
the line however means that when we complete this pass was_space will
be left set true and doesn't get reset before starting the 'copy
strings' pass.

This failure to reset the state of was_space between passes is the
root of the bug and the simplest patch to fix it is to reset it to
false around line 275. Hence, despite the fact that the two loops
within the function are superficially identical they can be coerced
into behaving differently on an identical string input. Inside the
'copy strings' pass we iterate over the string again, however because
was_space is now true instead of false as it was first time around we
enter the conditional at [6] and move the pointer to the start of the
string forward one character to skip the space.

This in turn means that by the time we reach [7] plen is correct to
match "post:", unlike in the first iteration.

So by the time we hit [8] we're in a position that we're copying bytes
and making array entries that weren't accounted for and aren't checked
against the previous counts.

Mitigation

Reset the state of was_space to false between passes.
For your assistance, we have provided the following code:

--- libkmod-config.c            2018-06-21 17:59:48.633600181 +0100
+++ libkmod-config.fixed        2018-09-12 21:42:34.499453017 +0100 @@
-333,6 +333,8 @@
                memcpy(dep->name ,modname ,modnamelen);
+        was_space = false;
+               /* copy strings */
               itr = dep->name + modnamelen;
               n_pre = 0;
