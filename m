Return-Path: <SRS0=rGSF=CB=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5444C433DF
	for <linux-modules@archiver.kernel.org>; Sun, 23 Aug 2020 21:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A002072D
	for <linux-modules@archiver.kernel.org>; Sun, 23 Aug 2020 21:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CV9MOO56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHWVyi (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 23 Aug 2020 17:54:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:53441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgHWVyh (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sun, 23 Aug 2020 17:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598219674;
        bh=51eequwrQlXqHSEbITO9p0fy2mNh61mrNkzqjjG/r1A=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=CV9MOO5649YsVm16kWeUkpMbN9ncYVBxVIR9rmRcdlEBHxgRyYn3uiPEKqFw+WaVH
         IMj0nCQI8ihmhqKjwmfi99WHIjsYPQV8ZkBC7DVM/pUuqp6i455piLGYoCDDCT392g
         6ZV4KBIizPD3xQCDd/Pnmd+Q58oF0VesKVfJYCRM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from blumerang ([95.114.63.203]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU5R-1knAVd06pX-00eh9S for
 <linux-modules@vger.kernel.org>; Sun, 23 Aug 2020 23:54:34 +0200
Date:   Sun, 23 Aug 2020 23:54:33 +0200
From:   Xaver =?utf-8?B?SMO2cmw=?= <hoe.dom@gmx.de>
To:     linux-modules@vger.kernel.org
Subject: [PATCH] modinfo: dont print module name when --field is given
Message-ID: <20200823215433.j5gc5rnsmahpf43v@blumerang>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Provags-ID: V03:K1:mgupsHGcMkm748dlyhW0f/bvbmgQvULfxT7n64EFbM9hCErfOOH
 fy+bQSq+nBHfAX5LzKo/5w7AHlg8Uxx5fviMezQh/G7vWjXgsTaghX7inhYYNUohr3Ff/GG
 mteU3gdOldV2EADHfbK0FH9VFn4kYCgXTi3sonbRZf7Cdn5WeUNfK7eJyCZN4JGYJWWsBBk
 ine+EQun578GYM4JQlihQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G99gf5w2yWs=:3kNWplQMEFmhV2LLtfVwEX
 d6yVrb1WqZk9V1RvvPEOSj7uwnAR9k5BDoz6O6I6ipxl1MGd6yuNiKtRdrC0f5o55hLRAXiox
 AR7qy8/qFEGkXMJ28GGKJXZXKfuwn/W+zabVRzJ3CgvyNhxzC6lK10NRIFsakJJVE7GiiWhdj
 X6c5e6Gxi0C1eoKBo+j0PaVMjJlwBHr42uixsZpWsCCofMouSjITz7n+Wx56Bt+6vCEaKVl25
 nojvxSrL4oPREQ4qYX5loq8Q8xgNK5oOu+ZA73O7V2ZRAab0rE71P62L0qxDwK/fz8rd2k8ZF
 5lKUmi7nU3VFmbXqIwT9STlqT8j2AKQdv2dDmvUhBfmojSVZeOrE/DdIyqqLRSPis0yEf7yMy
 bSsQ+3ENPOXVWS7X1aPqJ8+dXD+wS7XLb03r8T7mctWLIkLEjuj0SMY/f/L04guUBGat7fDQs
 YclTvmwtdlQq1sINAoiwhEF5XPP47Exi9BoqwRQ1s0GLZJMEjTk0spE4r0Zu/SGkCGxJGzFJu
 pt/eNJZIZj4JMAjZm0eVMwERlWOAdlB8H3yXWvTfAQboHnTu7fdQ2YhCkqhicUtxADttji5UT
 LZFARcdtR9xsLoIdnQzVJhF+eR4empqTssr0b+xnQtG7ez2bxSfp4w3NSumrgaCabELhF5fee
 1vjLrsRc1J4Ob0688cr5krORdfMdEY1BnytPga4HzcHBWrOBVmFKnQu0Wxrq9AJC2sqIijEOs
 6IE4T9Cv4mIPvyQtktKKK+kfoffxJFoR1CqjOYLvheopmeufjVfdwU6A38aullD4rKE9Kw+DF
 kH5J2WFz8VSZVNWlFoSYI8cQ7Phi7upoJ1c+FcAuu21l24kGrti50sqiYX9DvnjV2u7Z3oZ7i
 cLtiNWbgGeEUHqZmo5bJSpRv9SFnYtI5DXA24VxhasInkzTqSRv1osd6bt9B4zvWbyGE9N2X+
 JOK3IP5x+YFCr0nu7whgYtYSMjo7cf53tcoDNwresMHFCNzIJpt0ycKbyRfTezzTB8cbvaokq
 Y65/qqL+LBY3qXgs1Wj0pbStOzk6F8Hwj96NVJCplTmWSJwdcwHSVAV/tAzIy4Qefr/DkW0Wu
 tY3AktEIMPbrDLeY5KtRj/V/qk6gqIch44PV5Zsmi26RfDtDt3kWbERceIskZx4XzCU9UnUYC
 spCF8uWFe1Z7eXEV47TaJkPI6Kkr1PdZ72QhYay2Cs3r4WxQHdQuT9dtVMwNVUIhDzg7BHTjv
 oUgn535UTVM5zAqVD
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

I hope I found the right mailing list for this issue, which
came up here: https://github.com/NixOS/nixpkgs/pull/96008

The man page for modinfo claims that with the -F / --field option only
the specified field gets printed. Currently this is not true as for builti=
n modules, the name is always printed.

Try something like "modinfo -F firmware unix" for example.
It will print: "name:           unix"

So either the man page needs to be updated or the behaviour changed.
The following patch should fix this:

=2D--
 tools/modinfo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/modinfo.c b/tools/modinfo.c
index 0231bb0..7b2259e 100644
=2D-- a/tools/modinfo.c
+++ b/tools/modinfo.c
@@ -178,7 +178,10 @@ static int modinfo_do(struct kmod_module *mod)
 	is_builtin =3D (filename =3D=3D NULL);

 	if (is_builtin) {
-		printf("%-16s%s%c", "name:", kmod_module_get_name(mod), separator);
+		if (field =3D=3D NULL || field !=3D NULL && streq(field, "name")){
+			printf("%-16s%s%c", "name:",
+			       kmod_module_get_name(mod), separator);
+		}
 		filename =3D "(builtin)";
 	}

=2D-
2.28.0

