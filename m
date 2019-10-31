Return-Path: <SRS0=8kPO=YY=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE2ACA9ECB
	for <linux-modules@archiver.kernel.org>; Thu, 31 Oct 2019 18:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447EB2080F
	for <linux-modules@archiver.kernel.org>; Thu, 31 Oct 2019 18:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqMFIt+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfJaSNB (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:13:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22183 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726602AbfJaSNB (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 31 Oct 2019 14:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572545580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PgHgS8wxyrk2UAwaz8TKSOI/jaVcf6kI4ZFLgSl800w=;
        b=AqMFIt+ta8VfCw5lrjpnRCGCOIPSPbRANZ4gd5Whj9/TEIVVCYyTk3RPxZT8aK0UYmxA46
        bAFM2q6Bs7ZJbwj3rLjKetLlJ4xrNlvRZMAKlFt6M5tpui1cCYA++E7T/4yuRDCApyVOkZ
        KJkwyDRq0utOBsYhNM/eq6Cd9kDdODA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-uJVATSQZPcyl6PnPv0oQqQ-1; Thu, 31 Oct 2019 14:12:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CA50107ACC2;
        Thu, 31 Oct 2019 18:12:56 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-117-33.ams2.redhat.com [10.36.117.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 424E91001B32;
        Thu, 31 Oct 2019 18:12:55 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: [PATCH] modprobe: ignore builtin module on recursive removing
Date:   Thu, 31 Oct 2019 20:12:53 +0200
Message-Id: <20191031181253.18162-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: uJVATSQZPcyl6PnPv0oQqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

If there are built-in dependencies and any of them is built-in in
the kernel, modprobe -r fails with

modprobe: FATAL: Module module_name is builtin.

It makes sense to ignore such dependencies for the case when
removing is called for non-top level module.

Example: cifs module, it declares bunch of softdeps and the first
one fails on some kernel configs:

modprobe: FATAL: Module gcm is builtin.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/modprobe.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/modprobe.c b/tools/modprobe.c
index a9e2331567af..44cd15c2bf57 100644
--- a/tools/modprobe.c
+++ b/tools/modprobe.c
@@ -353,7 +353,8 @@ static int rmmod_do_remove_module(struct kmod_module *m=
od)
 =09return err;
 }
=20
-static int rmmod_do_module(struct kmod_module *mod, bool do_dependencies);
+static int rmmod_do_module(struct kmod_module *mod, bool do_dependencies,
+=09=09=09   bool ignore_builtin);
=20
 static int rmmod_do_deps_list(struct kmod_list *list, bool stop_on_errors)
 {
@@ -361,7 +362,7 @@ static int rmmod_do_deps_list(struct kmod_list *list, b=
ool stop_on_errors)
=20
 =09kmod_list_foreach_reverse(l, list) {
 =09=09struct kmod_module *m =3D kmod_module_get_module(l);
-=09=09int r =3D rmmod_do_module(m, false);
+=09=09int r =3D rmmod_do_module(m, false, true);
 =09=09kmod_module_unref(m);
=20
 =09=09if (r < 0 && stop_on_errors)
@@ -371,7 +372,8 @@ static int rmmod_do_deps_list(struct kmod_list *list, b=
ool stop_on_errors)
 =09return 0;
 }
=20
-static int rmmod_do_module(struct kmod_module *mod, bool do_dependencies)
+static int rmmod_do_module(struct kmod_module *mod, bool do_dependencies,
+=09=09=09   bool ignore_builtin)
 {
 =09const char *modname =3D kmod_module_get_name(mod);
 =09struct kmod_list *pre =3D NULL, *post =3D NULL;
@@ -401,8 +403,12 @@ static int rmmod_do_module(struct kmod_module *mod, bo=
ol do_dependencies)
 =09=09=09}
 =09=09=09goto error;
 =09=09} else if (state =3D=3D KMOD_MODULE_BUILTIN) {
-=09=09=09LOG("Module %s is builtin.\n", modname);
-=09=09=09err =3D -ENOENT;
+=09=09=09if (ignore_builtin) {
+=09=09=09=09err =3D 0;
+=09=09=09} else {
+=09=09=09=09LOG("Module %s is builtin.\n", modname);
+=09=09=09=09err =3D -ENOENT;
+=09=09=09}
 =09=09=09goto error;
 =09=09}
 =09}
@@ -462,7 +468,7 @@ static int rmmod(struct kmod_ctx *ctx, const char *alia=
s)
=20
 =09kmod_list_foreach(l, list) {
 =09=09struct kmod_module *mod =3D kmod_module_get_module(l);
-=09=09err =3D rmmod_do_module(mod, true);
+=09=09err =3D rmmod_do_module(mod, true, false);
 =09=09kmod_module_unref(mod);
 =09=09if (err < 0)
 =09=09=09break;
--=20
2.23.0

