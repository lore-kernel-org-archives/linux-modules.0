Return-Path: <SRS0=6exi=Y7=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173A8C5DF61
	for <linux-modules@archiver.kernel.org>; Thu,  7 Nov 2019 09:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2BE0206C3
	for <linux-modules@archiver.kernel.org>; Thu,  7 Nov 2019 09:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYF9JyYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfKGJaq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:30:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43592 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727278AbfKGJaq (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 7 Nov 2019 04:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573119045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxEP/BMV9TC69uDtFvcwdVsIYTkF6BQ/4Dv5SCaZup4=;
        b=TYF9JyYl1+JOybGn9IAmCeizPsjwQlQ+0upyH+01e/oV1vPJ3c2/cqeVJTwsTBKA3bnhz0
        z2c+vHd13gVMjUEEY5VoVLUHiVW0rOtBE2N5tMrdu4jaE1aBJSBqMi3vaFz+8mSB1QiMig
        FSibRIzlWotvKeWxg+CK0THsjHfOD3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-RV3kAY4dMIeYWQH02tL8Hg-1; Thu, 07 Nov 2019 04:30:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A960477;
        Thu,  7 Nov 2019 09:30:42 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-148.ams2.redhat.com [10.36.116.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76CC1600CE;
        Thu,  7 Nov 2019 09:30:41 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH] modprobe: use flags rather than bool args
References: <20191107073857.29596-1-lucas.demarchi@intel.com>
Date:   Thu, 07 Nov 2019 11:30:39 +0200
In-Reply-To: <20191107073857.29596-1-lucas.demarchi@intel.com> (Lucas De
        Marchi's message of "Wed, 6 Nov 2019 23:38:57 -0800")
Message-ID: <xuny5zjwdoe8.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: RV3kAY4dMIeYWQH02tL8Hg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi, Lucas!

>>>>> On Wed,  6 Nov 2019 23:38:57 -0800, Lucas De Marchi  wrote:

 > It's easier to know what the caller is doing when we pass a named
 > flag rather than a list of bools.

Yeah, it's much better, thanks!

 > ---
 >  tools/modprobe.c | 16 ++++++++--------
 >  1 file changed, 8 insertions(+), 8 deletions(-)

 > diff --git a/tools/modprobe.c b/tools/modprobe.c
 > index 44cd15c..9387537 100644
 > --- a/tools/modprobe.c
 > +++ b/tools/modprobe.c
 > @@ -353,8 +353,9 @@ static int rmmod_do_remove_module(struct kmod_module=
 *mod)
 >  =09return err;
 >  }
=20
 > -static int rmmod_do_module(struct kmod_module *mod, bool do_dependencie=
s,
 > -=09=09=09   bool ignore_builtin);
 > +#define RMMOD_FLAG_DO_DEPENDENCIES=090x1
 > +#define RMMOD_FLAG_IGNORE_BUILTIN=090x2
 > +static int rmmod_do_module(struct kmod_module *mod, int flags);
=20
 >  static int rmmod_do_deps_list(struct kmod_list *list, bool stop_on_erro=
rs)
 >  {
 > @@ -362,7 +363,7 @@ static int rmmod_do_deps_list(struct kmod_list *list=
, bool stop_on_errors)
=20
 >  =09kmod_list_foreach_reverse(l, list) {
 >  =09=09struct kmod_module *m =3D kmod_module_get_module(l);
 > -=09=09int r =3D rmmod_do_module(m, false, true);
 > +=09=09int r =3D rmmod_do_module(m, RMMOD_FLAG_IGNORE_BUILTIN);
 >  =09=09kmod_module_unref(m);
=20
 >  =09=09if (r < 0 && stop_on_errors)
 > @@ -372,8 +373,7 @@ static int rmmod_do_deps_list(struct kmod_list *list=
, bool stop_on_errors)
 >  =09return 0;
 >  }
=20
 > -static int rmmod_do_module(struct kmod_module *mod, bool do_dependencie=
s,
 > -=09=09=09   bool ignore_builtin)
 > +static int rmmod_do_module(struct kmod_module *mod, int flags)
 >  {
 >  =09const char *modname =3D kmod_module_get_name(mod);
 >  =09struct kmod_list *pre =3D NULL, *post =3D NULL;
 > @@ -403,7 +403,7 @@ static int rmmod_do_module(struct kmod_module *mod, =
bool do_dependencies,
 >  =09=09=09}
 >  =09=09=09goto error;
 >  =09=09} else if (state =3D=3D KMOD_MODULE_BUILTIN) {
 > -=09=09=09if (ignore_builtin) {
 > +=09=09=09if (flags & RMMOD_FLAG_IGNORE_BUILTIN) {
 >  =09=09=09=09err =3D 0;
 >  =09=09=09} else {
 >  =09=09=09=09LOG("Module %s is builtin.\n", modname);
 > @@ -415,7 +415,7 @@ static int rmmod_do_module(struct kmod_module *mod, =
bool do_dependencies,
=20
 >  =09rmmod_do_deps_list(post, false);
=20
 > -=09if (do_dependencies && remove_dependencies) {
 > +=09if ((flags & RMMOD_FLAG_DO_DEPENDENCIES) && remove_dependencies) {
 >  =09=09struct kmod_list *deps =3D kmod_module_get_dependencies(mod);
=20
 >  =09=09err =3D rmmod_do_deps_list(deps, true);
 > @@ -468,7 +468,7 @@ static int rmmod(struct kmod_ctx *ctx, const char *a=
lias)
=20
 >  =09kmod_list_foreach(l, list) {
 >  =09=09struct kmod_module *mod =3D kmod_module_get_module(l);
 > -=09=09err =3D rmmod_do_module(mod, true, false);
 > +=09=09err =3D rmmod_do_module(mod, RMMOD_FLAG_DO_DEPENDENCIES);
 >  =09=09kmod_module_unref(mod);
 >  =09=09if (err < 0)
 >  =09=09=09break;
 > --=20
 > 2.24.0


--=20
WBR,
Yauheni Kaliuta

