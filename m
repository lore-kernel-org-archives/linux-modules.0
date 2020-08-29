Return-Path: <SRS0=hxAR=CH=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F115C433E6
	for <linux-modules@archiver.kernel.org>; Sat, 29 Aug 2020 07:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3710720838
	for <linux-modules@archiver.kernel.org>; Sat, 29 Aug 2020 07:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fAinSf8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgH2Ht6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 29 Aug 2020 03:49:58 -0400
Received: from mout.gmx.net ([212.227.15.19]:33697 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgH2Ht5 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 29 Aug 2020 03:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598687382;
        bh=CRN7gxrHWKY8PuddBKnZbfdaUK2X4VSJCXmTTwPU/Ps=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=fAinSf8Gj+dQ5l+UjUnlXo93Mw4jIfh0ZU9PcSgbPjiXqiXT/dNYhqyNDAvj1BbQi
         WREdx/sVK7CTzVzyW+8j9AtPOxoYVE+t70YiPdrE0hq6OR8pJtdz2y67LdfowxTA/a
         hNO0satJ67BSupgteuwIljsBRhkrmRPSEceRRUfE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhD6W-1kp8FT3u7O-00ePnx; Sat, 29
 Aug 2020 09:49:42 +0200
Subject: Re: [ARM64][GCC10] Kernel can't load any module due to RWX check
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     linux-modules@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org
References: <b3158cec-b722-cbe8-5a82-47890a227da4@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <2d00ffc3-1176-1b80-20a5-e7f6babf924a@gmx.com>
Date:   Sat, 29 Aug 2020 15:49:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b3158cec-b722-cbe8-5a82-47890a227da4@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LrxD5NFIiGmv2PyffUTm0g4Tuo9YRoo6F"
X-Provags-ID: V03:K1:Bs94OsUul5z1P97cy+vLU/XrcbVKuzy6orjhbjMQJAYXoJN6zGl
 HDqK3jokS21eMaoezV2fHop8N0o25+/9Lk4bOUzeDziw5pQ0IWUQbve32r1S8b6YBsSvbL6
 aUdnx1yEvJSZc0ecXqZbINdCXOTyhIQyVnFOct/SdUUSljJIs3FN2l21ssPpIJkd/ES+Bwe
 hTw5/X03S4VQE0FFUbg7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1TYFiDu1Wfk=:K01qq/UKCxmZVNBricYOKp
 JcWQkKJlLAFa4sEvr7ri3/o8ZPZfYi4LKiAdxziP0kwRPDr9AH7EV9Kf4LoJLVcRwf9n0jPmr
 iNM6HE9OytoeHtdXIt6AIYVPxMQ+J3Tlu1f0nm9BNYHiVcf6BfYetYhM94OWpVo9C/BsqQcv6
 f9bcVFy0tGXZBcRb58dP8AaNk2g6tTH6M2elleqqFRV0fGE6RQ61SKBiIgyuYxfIhe5YBP27X
 06mCKqMWREKyn5ZhDu8W+qcuAiMnnihc4b0IoBcCFlXE0fx08yyRkCwGRRIatMZmItEpm44ky
 BlMzNPg2w547OhD0Iz3nR4gNrMJV5rhGq1KQDEGgDDOXIg73M0EB1yp3gh0Pn3umcy/1y+l9c
 9iyUu4mmfK4Eq+PBhYeN4DFos2EyVLEXUO26UjU9iHXqNnYKoL5TqMC1gt1jo2kgBDaF8vJaQ
 syhWDUuDoFvPTsxUBTxhTxqcETuqEGDcNWga0fL+UI1NA/bEDdlOtKikzooxtJR686bgi4i5c
 snQYUlBufGX62rTq/B/E5I3++SGEGTT0GdNTHynSP9HkPMcPW/ubW0+99j5sk2id4EeZCoGOE
 Em9tJ80T8p9/s8wE/UUS9kNSainED3ixhArRReaiGnLF7RVJOl53KDzfzm0JkA7XoIOp647A4
 DTGm1j47JWL23A0WJWbjSyRBd5tr6JJ6pDjS+RRTHX2MSy8iUgDLG5XgVOh2Bh3ARArOs0auT
 6N6jQLCj0KzZj/sPNfC72NqYuciCkYij0rsMK8fv+K2RBQzsCtqofFe1A1A1Vf+iwe5p7dBAd
 7YKITwIBpdeIzBvRvx3Q2uOa2Am4h5qQLh9SMYOCXm+WT9QrGbZhB4JeYdUZclGtrFpDwOaIf
 2oC2mk4pvsURq9ZkHwfwctNKh2p4CjOCv4uBKfDuz2tjZpx+pdsgwfk80l2DEx8ASWA6D9RNv
 xCu8vsMqzRewgRRCtlXrE6LncKnmeOSykC2wg7BIL2bsWxnKrf9Pem+KThh38NZUTGxD+CKBM
 drYlF8f1LgdZC39lU516s7VnMNUlL+i5sFKGq6qPiqUPt7URzA/UT6b4tArlhvjBuCLtooicH
 rZ9IQ87W0k1w0CBj+snHHefT/sQPH2flH3Jvb11h03jxSBtteLCFztzeGgi4Z4w9phygefSCi
 mLWQieYfISoLVq9itYVwNZ3x1pMYa0ZSZbvtrSAqz8nmld+qGEdREYWkwY9LXC9DH869s/8Z2
 sDV4LqeWFF7Y+UwTVXqyx7wpmRjcW+jkm+gNWzQ==
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LrxD5NFIiGmv2PyffUTm0g4Tuo9YRoo6F
Content-Type: multipart/mixed; boundary="rlFm2pJH6rwrEIdebavTa8tLQTszTJn8z"

--rlFm2pJH6rwrEIdebavTa8tLQTszTJn8z
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/29 =E4=B8=8B=E5=8D=883:44, Qu Wenruo wrote:
> Hi,
>=20
> Recently built a v5.9-rc2 kernel, it boots fine, but unable to load any=

> kernel module.
>=20
> After some debugging, it shows that it's due to RWX check failure:
>=20
>   load_module: start
>   module_enforce_rwx_sections: index=3D22 sh_flags=3D0x7 shf_wx=3D0x5
>   layout_and_allocate: module enforce rwx sections
>   load_module: failed to alloc layout and allocate
>   load_module: end
>=20
> Futhermore, it's unable to disable the RWX check through "make
> menuconfig", since the ARCH_OPTIONAL_KERNEL_RWX is no for arm64.
>=20
> The offending section 22 looks like this: (the kernel reports 38
> sectors, while we only have 37, thus near-by sections are also shown he=
re).
>=20
>  20 .data         00000aa0  0000000000000000  0000000000000000  00086d0=
8
>  2**3
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>  21 __bug_table   000000cc  0000000000000000  0000000000000000  000877a=
8
>  2**2
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>  22 __dyndbg      0000b9b8  0000000000000000  0000000000000000  0008787=
8
>  2**3
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>  23 .data.unlikely 00000012  0000000000000000  0000000000000000
> 00093230  2**0
>                   CONTENTS, ALLOC, LOAD, DATA
>=20
> I'm using GCC 10.2.0, could this be the cause?

I should check the git log, the module_enforce_rwx_sections() is just
recently added by commit 5c3a7db0c7ec ("module: Harden STRICT_MODULE_RWX"=
).

Hi Peter, any idea how could this commit causing a regression on arm64
but not on x86_64?

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20
>=20
>=20


--rlFm2pJH6rwrEIdebavTa8tLQTszTJn8z--

--LrxD5NFIiGmv2PyffUTm0g4Tuo9YRoo6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9KCJAACgkQwj2R86El
/qhL9gf/WpdLn2XUpSd4T5qN6nf2VzX2a2mbb7f2toVvhfqRx4s36dJ4QUBfih0N
oH71xcamNneLDZ3YkvEDSjow3Gu64Ug+WNT0KavG/xIRD8ThmydtUHvkEeR22hSy
bTAYpOQs/MeNxzBM9f6u0aupO7fkhqPFDXMBVWC8BjlthrT1F3AuB9x/nVrDSYlq
S474SsdFja5jOejlHMntA7hvIkXzazd14tlen3iqDwUzgzZ4zrPHgPivT4+zJAPs
E1ZGP13OVUt8MyFheF8cR/dJB8K4thk2N+VjSbXHTJzZU3SNJ0C6rgZiHjqhpPwg
M8zmzdTVnsDCsqFHf4XGosCwSY7nwg==
=0wz7
-----END PGP SIGNATURE-----

--LrxD5NFIiGmv2PyffUTm0g4Tuo9YRoo6F--
