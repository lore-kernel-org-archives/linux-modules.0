Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752132AbcKIC6j (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Tue, 8 Nov 2016 21:58:39 -0500
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        bjorn.andersson@linaro.org, afaerber@suse.de
Subject: Re: [PATCH v1 2/2] depmod: ignore related modules in depmod_report_cycles
References: <1478623550-18716-1-git-send-email-yousaf.kaukab@suse.com>
        <1478623550-18716-2-git-send-email-yousaf.kaukab@suse.com>
        <CAKi4VAKh0R-RN1j=Eum3wKtQ434D_7uBj1EGwzGCBrEB0qFkTg@mail.gmail.com>
Date: Wed, 09 Nov 2016 04:59:33 +0200
In-Reply-To: <CAKi4VAKh0R-RN1j=Eum3wKtQ434D_7uBj1EGwzGCBrEB0qFkTg@mail.gmail.com>
        (Lucas De Marchi's message of "Tue, 8 Nov 2016 22:40:20 -0200")
Message-ID: <xunyk2cdiciy.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi!

It may require more serious refactoring, since there is a problem with the
approach of path recording. I can get wrong output, for example, for the
following graph:

/*
  mod6 -> mod7 -> mod8 -> mod9
   ^               |       |
    ---------------        |
   |                       |
    -----------------------
*/

depmod: ERROR: Cycle detected: mod7 -> mod8 -> mod9 -> mod6 -> mod7
depmod: ERROR: Cycle detected: mod6 -> mod6
depmod: ERROR: Found 5 modules in dependency cycles!


The problem is that the path is recorded "globally", not per vertex, and
"wrong" mod6 is compared in "loop == m".


>>>>> On Tue, 8 Nov 2016 22:40:20 -0200, Lucas De Marchi  wrote:

 > On Tue, Nov 8, 2016 at 2:45 PM, Mian Yousaf Kaukab
 > <yousaf.kaukab@suse.com> wrote:
 >> Only print actual cyclic dependencies. Print count of all the modules
 >> in cyclic dependency at the end of the function so that dependent
 >> modules which are not in cyclic chain can be ignored.
 >> 
 >> Printing dependent modules which are not in cyclic chain causes buffer
 >> overflow as m->modnamesz is not included in buffer size calculations
 >> (loop == m is never true). This buffer overflow causes kmod to crash.
 >> 
 >> Update depmod test to reflect the change as well.
 >> 
 >> Reported-by: Andreas Färber <afaerber@suse.de>
 >> Signed-off-by: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
 >> ---
 >> Change-log:
 >> v1: Keep the old output stings. Only change their order
 >> Add test case to reproduce the problem
 >> 
 >> .../rootfs-pristine/test-depmod/detect-loop/correct.txt     |  2 +-
 >> tools/depmod.c                                              | 13 ++++++++++++-
 >> 2 files changed, 13 insertions(+), 2 deletions(-)
 >> 
 >> diff --git a/testsuite/rootfs-pristine/test-depmod/detect-loop/correct.txt b/testsuite/rootfs-pristine/test-depmod/detect-loop/correct.txt
 >> index 4eb26df..01ecb89 100644
 >> --- a/testsuite/rootfs-pristine/test-depmod/detect-loop/correct.txt
 >> +++ b/testsuite/rootfs-pristine/test-depmod/detect-loop/correct.txt
 >> @@ -1,3 +1,3 @@
 >> -depmod: ERROR: Found 5 modules in dependency cycles!
 >> depmod: ERROR: Cycle detected: mod_loop_d -> mod_loop_e -> mod_loop_d
 >> depmod: ERROR: Cycle detected: mod_loop_b -> mod_loop_c -> mod_loop_a -> mod_loop_b
 >> +depmod: ERROR: Found 5 modules in dependency cycles!
 >> diff --git a/tools/depmod.c b/tools/depmod.c
 >> index ad01f66..f2b370f 100644
 >> --- a/tools/depmod.c
 >> +++ b/tools/depmod.c
 >> @@ -1456,7 +1456,7 @@ static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
 >> {
 >> const char sep[] = " -> ";
 >> int ir = 0;
 >> -       ERR("Found %u modules in dependency cycles!\n", n_roots);
 >> +       int num_cyclic = 0;
 >> 
 >> while (n_roots > 0) {
 >> int is, ie;
 >> @@ -1491,6 +1491,7 @@ static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
 >> if (m->visited) {
 >> int i, n = 0, sz = 0;
 >> char *buf;
 >> +                               bool is_cyclic = false;
 >> 
 >> for (i = ie - 1; i >= 0; i--) {
 >> struct mod *loop = depmod->modules.array[edges[i]];
 >> @@ -1498,9 +1499,17 @@ static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
 >> n++;
 >> if (loop == m) {
 >> sz += loop->modnamesz - 1;
 >> +                                               is_cyclic = true;
 >> break;
 >> }
 >> }
 >> +                               /* Current module not found in dependency list.
 >> +                                * Must be a related module. Ignore it.
 >> +                                */
 >> +                               if (!is_cyclic)
 >> +                                       continue;
 >> +
 >> +                               num_cyclic += n;
 >> 
 >> buf = malloc(sz + n * strlen(sep) + 1);
 >> sz = 0;
 >> @@ -1538,6 +1547,8 @@ static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
 >> }
 >> }
 >> }
 >> +
 >> +       ERR("Found %d modules in dependency cycles!\n", num_cyclic);
 >> }

 > thanks, much better now.

 > Applied.

-- 
WBR,
Yauheni Kaliuta
