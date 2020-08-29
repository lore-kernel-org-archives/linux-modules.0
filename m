Return-Path: <SRS0=hxAR=CH=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD199C433E6
	for <linux-modules@archiver.kernel.org>; Sat, 29 Aug 2020 07:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB5020757
	for <linux-modules@archiver.kernel.org>; Sat, 29 Aug 2020 07:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IDo/yWiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgH2H5e (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 29 Aug 2020 03:57:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:57397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgH2H5a (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 29 Aug 2020 03:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598687833;
        bh=CuxZR102rouEbn/N5VOyo6/7AEaK1X2WX8GFK9IR57w=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=IDo/yWiUtEZ3o7q4NtHJeurysVyzgf9L+9gGHKn4iS2tZPn1xPTA/TvfBPweFsQuH
         2I/04Dw/eBp+kilcYRto9b1s0tquThqoHysJMcCg4/rx5kjNA0XKNFzBvPQR0CK8oG
         n2PDb1SX9Vv57tEY8AHFULQ9QDPnfom22dQ1pBnw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbRfv-1kjKkI3qJt-00bug2; Sat, 29
 Aug 2020 09:57:13 +0200
Subject: Re: [ARM64][GCC10] Kernel can't load any module due to RWX check
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     linux-modules@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org
References: <b3158cec-b722-cbe8-5a82-47890a227da4@gmx.com>
 <2d00ffc3-1176-1b80-20a5-e7f6babf924a@gmx.com>
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
Message-ID: <5390e084-1b0f-9508-204c-6fae39a7ae96@gmx.com>
Date:   Sat, 29 Aug 2020 15:57:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2d00ffc3-1176-1b80-20a5-e7f6babf924a@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TVEla8TlWZXg4DbWQoDDyitEWy01Ku6r3"
X-Provags-ID: V03:K1:eZeJj9dhYwgRqSSoITUv9k6HGOmxsWZL2Y8piAMQIE9wBJTZSfk
 7cd/cHTTU0Vq/jgHzg4e1FWE1+ERgCjo2CtWkPG8sTqTNyvCJRFKXN/kGRNniVXZ2OrVQhx
 Bz5FLKo60RdJFvi4kpSM2id7Dx1hNpoAuNa7pw5CooM2OYowiTVZj7gArFvhrUTAdtSfeiI
 0//sZtS/P++fESR76OVjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eDAQSodC1y4=:tXGhUvuGQwbujQGtXxmwz3
 9GVILF0QI2ugrkWI9nQI2FT29rmtBl5NoBHh8tXS/QqKCB2jpImLbRydumslzvay7+mtH/IPV
 glytFBHkviXEeSPhKa2L8mfcxnMHEDNnz6dVk+GaiNIkWTSOoQRap2mgZ5jehfrAsO/gWtZaU
 0NTx0rFKg32rtiL1No5BTwFO2zJQUovMD9ZrsfhCHPy3o/2B65Yh3OM+N01FKy3YVJEhPUT4k
 0Um1y+NnZW0A0yaIYZQsr3xYLtUXGDV1eeROvR5Xl5k6mNXK6EPH8qJsZ2hSzqmE2mi8NZQAP
 a6oPw+/A0iP+dfEywlQwey/lQAUYkt/ciZt8B+y1iRdtrvDCdNtNxcELNTuaoUvVobcnSZk7t
 YoFje82GT0UYN8McKZ146cldMMnEqu4TeID/tWyq9qGpJPV91ULsgEIBIF3LsOP+G2SS3/3Eq
 2PENGHqzadTSHyjkuAVe9bZn3+FEDAumlBx5YpxEgOXwZPZvpGKawHq5i5XS4FcHwivMpO8pK
 u27H0Zkt+QsZ2mba1Tytgagcpc5fBiwrEP613uu3YooeCqAANQV2ui0V2mMACKdg3nkdb5c4b
 8OGi7pTbTZAb7qkIc6q1yGdXCmfptnaABvUR0UJU2nTCUGxiQ9zplM/jfJfpEZ44sDJ5z84HM
 2sKqhYO8kX3sTk4yRwoq5kalkVdVtN9Bg9C1jio6+0dzZ76tV+xZ/nynsP9RG0fjA84DjMJ17
 nAWLIXrBRcN6rXjRkPi+dYRgs6HV8+wURiuJ5fs7T/L595SI5LF1/zoSUoXbJdBgP2Z/TDcOx
 W1cbUVslxRL7Vp1B3slRUa2mriKk4AgAK+a5EJR3d3z9vzjQsvFPoCw50P+8OwemJPTprO5wO
 eazR4onGSZ+bUncreMeajvd/r2vX6C79L5Z3167vFqQT1NJ2ScOZ1lDMpSzU21IpzbtF3kKEO
 ev5k9kAgwDv+7EI3M9atRzkEh2L2/JLyP6GaOfdNnsJo3an41myzMJE7c/UQ2leA7zpKlhVp3
 bskMLFZ6dsdbE6eTpBsBG+5/UPAEb+W7mgNa5IPvjCSqcmF1WUcvAHJ5xhpqC1eoFZ4RfrFpx
 RVkbWv5VlczvlQagiG9vjB0McYe2Zekjs9yIz5M8ihQzRxsJBoOvIu7EQ7bIV+lVve6ThoVPW
 PXDKx6MeQj34pqTy661Yzfi7yvI5n8b7gw/I33GNipoVzXA+Bxe1pOdXsMf+Xs2UbIgby/LTP
 w3F7TRBIkNgYCPfXo7mqtkn5pY97iihw/Ntd+4w==
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TVEla8TlWZXg4DbWQoDDyitEWy01Ku6r3
Content-Type: multipart/mixed; boundary="bXZ1IWHlQt0CDLxf6caHLlw6e0y21LA6O"

--bXZ1IWHlQt0CDLxf6caHLlw6e0y21LA6O
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/29 =E4=B8=8B=E5=8D=883:49, Qu Wenruo wrote:
>=20
>=20
> On 2020/8/29 =E4=B8=8B=E5=8D=883:44, Qu Wenruo wrote:
>> Hi,
>>
>> Recently built a v5.9-rc2 kernel, it boots fine, but unable to load an=
y
>> kernel module.
>>
>> After some debugging, it shows that it's due to RWX check failure:
>>
>>   load_module: start
>>   module_enforce_rwx_sections: index=3D22 sh_flags=3D0x7 shf_wx=3D0x5
>>   layout_and_allocate: module enforce rwx sections
>>   load_module: failed to alloc layout and allocate
>>   load_module: end
>>
>> Futhermore, it's unable to disable the RWX check through "make
>> menuconfig", since the ARCH_OPTIONAL_KERNEL_RWX is no for arm64.
>>
>> The offending section 22 looks like this: (the kernel reports 38
>> sectors, while we only have 37, thus near-by sections are also shown h=
ere).
>>
>>  20 .data         00000aa0  0000000000000000  0000000000000000  00086d=
08
>>  2**3
>>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>>  21 __bug_table   000000cc  0000000000000000  0000000000000000  000877=
a8
>>  2**2
>>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>>  22 __dyndbg      0000b9b8  0000000000000000  0000000000000000  000878=
78
>>  2**3
>>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>>  23 .data.unlikely 00000012  0000000000000000  0000000000000000
>> 00093230  2**0
>>                   CONTENTS, ALLOC, LOAD, DATA
>>
>> I'm using GCC 10.2.0, could this be the cause?
>=20
> I should check the git log, the module_enforce_rwx_sections() is just
> recently added by commit 5c3a7db0c7ec ("module: Harden STRICT_MODULE_RW=
X").
>=20
> Hi Peter, any idea how could this commit causing a regression on arm64
> but not on x86_64?

And obviously, reverting it solves the problem of mine.
(Now happy working 4K sector size btrfs support on 64K page size system)

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20
>>
>> Thanks,
>> Qu
>>
>>
>>
>=20


--bXZ1IWHlQt0CDLxf6caHLlw6e0y21LA6O--

--TVEla8TlWZXg4DbWQoDDyitEWy01Ku6r3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9KClIACgkQwj2R86El
/qhCggf/Uub/oMRfLkHbu1GzbWTjhJ+s1qPBYFIyMyGaVgrcDEDHC7q9h/48CSp3
QqkmtuVRNlKLBZlTia+3ECdlvlTfeuSxQKAM6dGqE84vZS8eSTNb8ZnPprfr8Qzc
i/BtP4zJ+DzJv3QiKpkBKbzhLgrNl2NSr90/A48W8E/y+hc5Q2jNG+de9uBQ0YpP
32yboyVXriQKwYP16v3VX+4cC2owJbkIyx0FHZEoiE3TdCg33ImgaD3RX3TEMMro
r9QQNevpcFH370YNocmzevbEuqAFE+ePPvZn3B+LWI6ijswW0hVg8MCvVaNvQyHH
Y1kbKRy1vJ0ibz48gbDjI1jL3Q7f+g==
=UfcU
-----END PGP SIGNATURE-----

--TVEla8TlWZXg4DbWQoDDyitEWy01Ku6r3--
