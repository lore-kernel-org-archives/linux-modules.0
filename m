Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFF0C77B71
	for <linux-modules@archiver.kernel.org>; Tue, 18 Apr 2023 10:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjDRKLN (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 Apr 2023 06:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjDRKLL (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 Apr 2023 06:11:11 -0400
X-Greylist: delayed 4671 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Apr 2023 03:10:36 PDT
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1067AA7
        for <linux-modules@vger.kernel.org>; Tue, 18 Apr 2023 03:10:36 -0700 (PDT)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Tue, 18 Apr 2023 12:10:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1681812633; bh=DO8lLyHscw6uP5DG0wX431O+BloBpJWFwi9X1tZYaKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NjRdCyTQu0CiYMBLJztkGni/lCikNn1Dfo1SZDS9kR8Kanr8xWCfIDjUtNsEhsaKY
         0X86yEfSifTq77aotbapJ8yBOv9R4ZqKpejljTvTsCm18o+nj4b6HqpJhMnam/dUe9
         GECmcOpdKtvzLyFWcQftnus/qOcVlm3SrubP4zZ8=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id F335280463;
        Tue, 18 Apr 2023 12:10:32 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id E8A8018224B; Tue, 18 Apr 2023 12:10:32 +0200 (CEST)
Date:   Tue, 18 Apr 2023 12:10:30 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-modules@vger.kernel.org,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v2 1/3] kmod: modprobe: Remove holders recursively
Message-ID: <ZD5smMLRyQSUsIYx@buildd.core.avm.de>
References: <20230309-remove-holders-recursively-v2-0-8a8120269cc1@avm.de>
 <20230309-remove-holders-recursively-v2-1-8a8120269cc1@avm.de>
 <20230412192151.jbbcltmcwwamhlm6@ldmartin-desk2.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="715RLcwRLSvdG3hg"
Content-Disposition: inline
In-Reply-To: <20230412192151.jbbcltmcwwamhlm6@ldmartin-desk2.lan>
X-purgate-ID: 149429::1681812633-D4B4D29D-48BE7653/0/0
X-purgate-type: clean
X-purgate-size: 12713
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


--715RLcwRLSvdG3hg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Apr 2023 12:10:30 +0200
From: Nicolas Schier <n.schier@avm.de>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v2 1/3] kmod: modprobe: Remove holders recursively

On Wed, Apr 12, 2023 at 12:21:51PM -0700, Lucas De Marchi wrote:
> On Wed, Mar 29, 2023 at 03:51:35PM +0200, Nicolas Schier wrote:
> > Remove holders recursively when removal of module holders is requested.
> >=20
> > Extend commit 42b32d30c38e ("modprobe: Fix holders removal") by removing
> > also indirect holders if --remove-holders is set.  For a simple module
> > dependency chain like
> >=20
> >  module3 depends on module2
> >  module2 depends on module1
> >=20
> > 'modprobe -r --remove-holders module1' will remove module3, module2 and
> > module1 in correct order:
> >=20
> >  $ modprobe -r --remove-holders module1 --verbose
> >  rmmod module3
> >  rmmod module2
> >  rmmod module1
> >=20
> > (Actually, it will do the same when specifying module2 or module3 for
> > removal instead of module1.)
> >=20
> > As a side-effect, 'modprobe -r module3' (w/o --remove-holders) will also
> > remove all three modules from the example above, as after removal of
> > module3, module2 does not have any holders and the same holds for
> > module1 after removal of module2:
> >=20
> >  $ modprobe -r module3 --verbose
> >  rmmod module3
> >  rmmod module2
> >  rmmod module1
> >=20
> > Without recursive evaluation of holders, modprobe leaves module1 loaded.
> >=20
> > Unfortunately, '--dry-run --remove-holders' breaks with indirect
> > dependencies.
> >=20
> > Signed-off-by: Nicolas Schier <n.schier@avm.de>
> > ---
> > I am a bit unhappy about the introduction of the 'recursive' parameter
>=20
> yeah... it makes it slightly harder to read.
>=20
> > to rmmod_do_modlist() as it always holds the same value as
> > stop_on_errors; is re-using (and renaming) possibly a better option?
> >=20
> > modprobe --remove --remove-holders --dry-run now ignores current
> > refcounts of loaded modules when simulating removal of holders.
> >=20
> > Changes in v2:
> >  * Handle modules that have just been removed, gently
> >  * Fix --dry-run by ignoring module refcounts (_only_ for --dry-run)
> >  * Add missing kmod_module_unref_list() calls
> > ---
> > tools/modprobe.c | 44 +++++++++++++++++++++++++++++++++++---------
> > 1 file changed, 35 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/tools/modprobe.c b/tools/modprobe.c
> > index 3b7897c..a705f88 100644
> > --- a/tools/modprobe.c
> > +++ b/tools/modprobe.c
> > @@ -390,13 +390,27 @@ static int rmmod_do_remove_module(struct kmod_mod=
ule *mod)
> > static int rmmod_do_module(struct kmod_module *mod, int flags);
> >=20
> > /* Remove modules in reverse order */
> > -static int rmmod_do_modlist(struct kmod_list *list, bool stop_on_error=
s)
> > +static int rmmod_do_modlist(struct kmod_list *list, bool stop_on_error=
s,
> > +			    bool recursive)
> > {
> > 	struct kmod_list *l;
> >=20
> > 	kmod_list_foreach_reverse(l, list) {
> > 		struct kmod_module *m =3D kmod_module_get_module(l);
> > -		int r =3D rmmod_do_module(m, RMMOD_FLAG_IGNORE_BUILTIN);
> > +		int r =3D 0;
> > +
> > +		if (recursive && kmod_module_get_initstate(m) >=3D 0) {
> > +			struct kmod_list *holders =3D kmod_module_get_holders(m);
> > +
> > +			r =3D rmmod_do_modlist(holders, stop_on_errors,
> > +					     recursive);
> > +
> > +			kmod_module_unref_list(holders);
> > +		}
> > +
> > +		if (!r)
> > +			r =3D rmmod_do_module(m, RMMOD_FLAG_IGNORE_BUILTIN);
> > +
> > 		kmod_module_unref(m);
> >=20
> > 		if (r < 0 && stop_on_errors)
> > @@ -448,15 +462,17 @@ static int rmmod_do_module(struct kmod_module *mo=
d, int flags)
> > 	}
> >=20
> > 	/* 1. @mod's post-softdeps in reverse order */
> > -	rmmod_do_modlist(post, false);
> > +	rmmod_do_modlist(post, false, false);
> >=20
> > 	/* 2. Other modules holding @mod */
> > 	if (flags & RMMOD_FLAG_REMOVE_HOLDERS) {
> > 		struct kmod_list *holders =3D kmod_module_get_holders(mod);
> >=20
> > -		err =3D rmmod_do_modlist(holders, true);
> > +		err =3D rmmod_do_modlist(holders, true, true);
> > 		if (err < 0)
> > 			goto error;
> > +
> > +		kmod_module_unref_list(holders);
>=20
> this is a separate fix. We also need to unref it on error, so probably
> best to do:
>=20
> 	err =3D rmmod_do_modlist(holders, true, true);
> 	kmod_module_unref_list(holders);
> 	if (err < 0)
> 		goto error;

Thanks!  Yes, sure.  I sent it as a separate patch at
https://lore.kernel.org/linux-modules/20230418-add-missing-kmod_module_unre=
f_list-v1-1-ab5b554f15ee@avm.de/

>=20
> I think the alternative to the recursive approach would be to make only
> the kmod_module_get_holders() be recursive:
>=20
> 	struct kmod_list *holders =3D recursive_holders(mod);
>=20
> And let recursive holders do recurse on modules passing the list as
> argument to be augmented. Then the rest remains the same.

Yes, that sounds much nicer than the stuff I did.  I will try and send a v3.

> > 	}
> >=20
> > 	/* 3. @mod itself, but check for refcnt first */
> > @@ -472,9 +488,16 @@ static int rmmod_do_module(struct kmod_module *mod=
, int flags)
> > 		}
> > 	}
> >=20
> > -	if (!cmd)
> > -		err =3D rmmod_do_remove_module(mod);
> > -	else
> > +	if (!cmd) {
> > +		int state =3D kmod_module_get_initstate(mod);
> > +
> > +		if (state < 0) {
> > +			/* Module was removed during recursive holder removal */
> > +			err =3D 0;
>=20
> wouldn't this fall in this case inside rmmod_do_remove_module()?
>=20
> 	err =3D kmod_module_remove_module(mod, flags);
> 	if (err =3D=3D -EEXIST) {
> 		if (!first_time)
> 			err =3D 0;

No, as the module might already be removed and kmod_module_remove_module() =
thus
returns -ENOENT.  I think, your suggestion to regarding introduction of
recursive_holders() should remove the need for checking the kmod state here.

FTR: I tested the current patch w/o the kmod state check; as expected, it l=
eads to errors:

testsuite failure, when using --remove-holders:

    rmmod mod_dep_chain_c
    TESTSUITE: Added module to test delete_module:
    TESTSUITE: 	name=3Dmod_dep_chain_c ret=3D0 errcode=3D0
    TESTSUITE: Added module to test delete_module:
    TESTSUITE: 	name=3Dmod_dep_chain_b ret=3D0 errcode=3D0
    TESTSUITE: Added module to test delete_module:
    TESTSUITE: 	name=3Dmod_dep_chain_a ret=3D0 errcode=3D0
    rmmod mod_dep_chain_b
    libkmod: kmod_module_get_holders: could not open '/sys/module/mod_dep_c=
hain_c/holders': No such file or directory
    rmmod mod_dep_chain_a
    libkmod: kmod_module_get_holders: could not open '/sys/module/mod_dep_c=
hain_c/holders': No such file or directory
    libkmod: kmod_module_get_holders: could not open '/sys/module/mod_dep_c=
hain_b/holders': No such file or directory
    rmmod mod_dep_chain_a
    libkmod: kmod_module_get_holders: could not open '/sys/module/mod_dep_c=
hain_c/holders': No such file or directory
    libkmod: kmod_module_get_holders: could not open '/sys/module/mod_dep_c=
hain_b/holders': No such file or directory
    libkmod: kmod_module_get_holders: could not open '/sys/module/mod_dep_c=
hain_a/holders': No such file or directory
    modprobe: ERROR: could not remove 'mod_dep_chain_a': No such file or di=
rectory
    TESTSUITE: ERR: TRAP delete_module(): /home/nicolas/src/kmod/testsuite/=
rootfs/test-modprobe/remove-holders/sys/module/mod_dep_chain_a: opendir: No=
 such file or directory
    TESTSUITE: ERR: TRAP delete_module(): unable to adjust sysfs tree
    TESTSUITE: running modprobe_remove_with_holders, in forked context
    TESTSUITE: ERR: 'modprobe_remove_with_holders' [2320200] exited with re=
turn code 1
    TESTSUITE: ERR: FAILED: modprobe_remove_with_holders
    TESTSUITE: ------
    FAIL testsuite/test-modprobe (exit status: 1)

and on my dev maschine I also see attempts of module removal that fail:

The relevant snippets from lsmod output:

    btrfs                1777664  0
    zstd_compress         294912  1 btrfs
    ...
    raid456               180224  0
    async_raid6_recov      24576  1 raid456
    async_memcpy           20480  2 raid456,async_raid6_recov
    async_pq               20480  2 raid456,async_raid6_recov
    async_xor              20480  3 async_pq,raid456,async_raid6_recov
    async_tx               20480  5 async_pq,async_memcpy,async_xor,raid456=
,async_raid6_recov
    xor                    24576  2 async_xor,btrfs
    raid6_pq              122880  4 async_pq,btrfs,raid456,async_raid6_recov

and the modprobe call, without the additional kmod state check:

    sudo tools/modprobe -r --remove-holders xor -vv
    modprobe: INFO: custom logging function 0x5564236f5700 registered
    rmmod btrfs
    rmmod zstd_compress
    rmmod raid456
    rmmod async_raid6_recov
    rmmod async_pq
    rmmod raid6_pq
    rmmod async_xor
    rmmod xor
    rmmod async_memcpy
    rmmod async_tx
    rmmod xor
    modprobe: ERROR: could not remove 'xor': No such file or directory
    modprobe: INFO: context 0x556423e68440 released
    [exit code 1]

Both, testsuite and the modprobe -r, succeed as w/o complaints with the kmod
state check included.


(Again, as written above: I hope the kmod state check insertion becomes
obsolete when switching to something like recursive_holders().)


> > +		} else {
> > +			err =3D rmmod_do_remove_module(mod);
> > +		}
> > +	} else
> > 		err =3D command_do(mod, "remove", cmd, NULL);
> >=20
> > 	if (err < 0)
> > @@ -488,14 +511,14 @@ static int rmmod_do_module(struct kmod_module *mo=
d, int flags)
> > 		kmod_list_foreach(itr, deps) {
> > 			struct kmod_module *dep =3D kmod_module_get_module(itr);
> > 			if (kmod_module_get_refcnt(dep) =3D=3D 0)
> > -				rmmod_do_remove_module(dep);
> > +				rmmod_do_module(dep, flags);
>=20
> not sure also recursing the holders of the modules left is what we want.
> If there are holders, then the module's refcnt should not be 0 anyway.
>=20
> Lucas De Marchi

Yeah, I have no strong opinion to that.  Currently, 'modprobe -r
--remove-holders MOD' removes only direct dependencies of MOD if they have =
a refcnt
of 0 after MOD has been removed.  I think, removing MOD's dependencies
recursively, would make it more of an inverse operation:

   modprobe mod-dep-chain-c   (loads mod-dep-chain-a, -b and -c)
   modprobe -r --remove-holders mod-dep-chain-c  (unloads only mod-dep-chai=
n-b ?)

(If option '--remove-dependencies' wasn't burned, it could have been a
switch to enable this?)

But I cannot say, if someone really needs that functionality; thus, I
will drop it in v3.


Thanks for review and suggestions!

Kind regards,
Nicolas


> > 			kmod_module_unref(dep);
> > 		}
> > 		kmod_module_unref_list(deps);
> > 	}
> >=20
> > 	/* 5. @mod's pre-softdeps in reverse order: errors are non-fatal */
> > -	rmmod_do_modlist(pre, false);
> > +	rmmod_do_modlist(pre, false, false);
> >=20
> > error:
> > 	kmod_module_unref_list(pre);
> > @@ -975,6 +998,9 @@ static int do_modprobe(int argc, char **orig_argv)
> > 	     fstat(fileno(stderr), &stat_buf)))
> > 		use_syslog =3D 1;
> >=20
> > +	if (remove_holders && dry_run)
> > +		ignore_loaded =3D 1;
> > +
> > 	log_open(use_syslog);
> >=20
> > 	if (!do_show_config) {
> >=20
> > --=20
> > 2.40.0
> >=20

--715RLcwRLSvdG3hg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmQ+bJYACgkQiMa8nIia
bbhbVA/48xzViqf5ef6S7iZHN6mETkjD9N9uxPzwzjh8d4acQM85H7E2aevWEBkM
2qEWVefyAx6wZtS2Sbl6RC8sHnB307oqdseqaL6VVm8TEcBo+24DL0V+tT2iEjy8
+2UHVlhsJ98FmqfSawhVh3QaXc9o1qzscXyDhVpY0H8TYYykHWCMGm03aEhyJzys
TrPt0vBJRkko955kolTrcXTkm8rzqsWKs0UKpcGEpjv+G5ZqNRwLDQO02RuWEeKU
fnETnQA/PA3laSe/QAl28rQa5AK1AOdNhpHzeYdLKQuE4pwGAxIzdds8fvV0Mtg2
ICaIOczdKdkcoBwqwGIBT2ANN8pk0QbmGeu+pZrVOPLiMkKcyaQQQfj6rvNhB9bl
cNNtqNPCEeWFCWbyhRCZr/2IzA41rBPnu6/FWGxZVMBc/D7428l72Rk/NJom7ihX
IUJk3wHpoF90Qdk5vVxDua2VyoaymmfJP/9cOlA1kpqNw5l3kOzqPUdmqzNRVINF
WvpCRexRBoiiGODNJhRUGj8pLsoZmF5KCZYmkeD8InzQ/0AOTrG2JjmC8VYOwDGX
SgibOXU7v0BUnTK+k8uap0R3vYkryTdGw4xu7qA33dsoxAivc5BdCxiOOsfFJKod
RL3hls1fRe/nrTkfNsrmrVY8r1dbgfk0K+lWf1LyuG8He44KRA==
=TniA
-----END PGP SIGNATURE-----

--715RLcwRLSvdG3hg--
