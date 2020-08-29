Return-Path: <SRS0=hxAR=CH=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEECC433E2
	for <linux-modules@archiver.kernel.org>; Sat, 29 Aug 2020 07:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 736B920825
	for <linux-modules@archiver.kernel.org>; Sat, 29 Aug 2020 07:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KtWgrqFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgH2Hoz (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 29 Aug 2020 03:44:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:47703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgH2How (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Sat, 29 Aug 2020 03:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598687082;
        bh=JiEtvFyJSQXEQ7IqLEcJUNpYqf6aWCP6Q7mVFEgHDTk=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=KtWgrqFXJEfVRRlpbc1seqF20f2rAb0GjN7oT+0r20TvPZRWVdEldCBe4aQDhA6fz
         YyGNedtpCzXkWEScKQwBPTGhx0a+TjwG+Ne6bI9mvNBYnCoiO4dRgzcnNSrpdnQF14
         lSWTm/my5UpxHepJ/Ln2joT3S0m6dgQhD+3BLCh8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbRk3-1kjLTk18Uj-00brQe; Sat, 29
 Aug 2020 09:44:41 +0200
To:     linux-modules@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: [ARM64][GCC10] Kernel can't load any module due to RWX check
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
Message-ID: <b3158cec-b722-cbe8-5a82-47890a227da4@gmx.com>
Date:   Sat, 29 Aug 2020 15:44:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r0puDL8kytkufoMaAbP3T6qbmrRMWNN9l"
X-Provags-ID: V03:K1:69F89smqq4Hy6xztI6uyuFF+iSZK6YhDVa7FIVUHo7VjtmQMOTn
 EDEB/VAsH0Fno+6AvvDsQcW8tNM0zhhcsFh90oDSnQ+muVFxwLjvzU4V2vcrGny3b86ocz4
 SfcTLiCNQHonU5KvUobfe1xj34mn/0u/fqvX1nzGzQvw1JWoVv/wDEpV9D5PyHB+d6xFxVN
 6Jj+7o40+SqWHZ8kPDB7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u1GMnS/k7D0=:HM7VylraJU8hbyepA+vnpJ
 5IopTy4sFBZAcgfTFs7u8Y889vILbodehMduT7eDJnZJw6ze+f/hg5dc5qKCTbTp92BF+3//v
 91YxkwmrnlfC0hts3/NQt6/OwwgYB1yXCNjTNKRruU8E2bDSoPJ+UpEUGhrQQaSxcDwU7aBD0
 SvptwYUQErVPNZZvRtVL9OXO6Op4/YWGv2df/IhgBi5GAbmZTPd6/J1jGUKTCJNMrts4JIxl+
 1tNqFbFDmsC93jjUpfmwBqbdPh6GZ+lzvbcEbYtWPMWQfZmYSyeBSRTyUXSVpKlf9Qv9xNBzb
 lSt5h851uHQX3w1npD9Tuu1DbUCODCQ6MQ4ZWZT5Pg3nzmVprl3AJiKbDqR9dIboiiGkZGP+C
 PByDvEqC+u1W5CWq8FtEU+BqEjxe4GOxcOEaouUFNSnqQZdI/YF8zxHmDCcwEnPtwlkrynJRf
 m/4+lcFR3xi43JZy393ADtakrgntgaru95pIa8JGzwGTQDCpRKZMmqnZbgUNqDq0kXAC8vRwu
 YhEFpsL+Bxlp0uusxKpGzl5NsK4xAYElYFhuNmIf43s/y8kTsFY7TI276uwTR8BD+2xGt/iop
 4tZO4H3Qpcw7jtlW/fV6FNNRa3SkjuPt8Ho6on/HUhoK1YwNN9F9Jf1OB/ZjxyCgJNWtcbwMw
 E48mfZXalF6dt+IHlCdGEWyO/D3FU/xaLC8xCiq7TioTQAd4bu8g10asvnVwLhHhJM5/v8Xbj
 wxWfcy3Nvt4NqBkgY1sHn1jCygVt5YRwbEB3M+w+nyYwt6TaoFNABTRgs9GODv7fM11jO4LU7
 0R+poD1CnKlbUzzR1TSPiyw0qImFJv3tpl1l2M0aHe79s/I6i8DGqFTrIyqdy8cxPy3+UpHfG
 j93YgHgseufFRnzKXKDZIJcsySYPfG7b2b8xFlTa2oHlpiMNEcnbewkcDYWQN7G1I1pwQfnd4
 Yu7CPCiJogxAR2JuMKPC24OnuvzLlzmjJRaMm/la3eexRPFNUQryWpnJS6Euohx1luVQHghs+
 b7KZIE9NvdDLaA/cwK40dGl2y2wy9JXNIhP6xps9jvhXH2SlYt0HpDXaSM+doVFFfzddTqgbL
 RUob+h/vnjikuGMDyPhi5iPWmetzoYZMfScsVPIj18rphTqBZqZ7vo+0pUsyNtcYwI0kVuN/m
 3E2Kwq6PcrXgXC1+B9KjrhcBDlUs8+RSkccexiPYIgF0boAxKuJ2fL4GmluHxAOKdJVhrbpT2
 X4QDARIzehbrK9eofI/NGK8MsuiKPXdlYFxwndw==
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r0puDL8kytkufoMaAbP3T6qbmrRMWNN9l
Content-Type: multipart/mixed; boundary="7ejKiFIvzwU9aYummV4rTC4oQP8BckAvo"

--7ejKiFIvzwU9aYummV4rTC4oQP8BckAvo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Recently built a v5.9-rc2 kernel, it boots fine, but unable to load any
kernel module.

After some debugging, it shows that it's due to RWX check failure:

  load_module: start
  module_enforce_rwx_sections: index=3D22 sh_flags=3D0x7 shf_wx=3D0x5
  layout_and_allocate: module enforce rwx sections
  load_module: failed to alloc layout and allocate
  load_module: end

Futhermore, it's unable to disable the RWX check through "make
menuconfig", since the ARCH_OPTIONAL_KERNEL_RWX is no for arm64.

The offending section 22 looks like this: (the kernel reports 38
sectors, while we only have 37, thus near-by sections are also shown here=
).

 20 .data         00000aa0  0000000000000000  0000000000000000  00086d08
 2**3
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
 21 __bug_table   000000cc  0000000000000000  0000000000000000  000877a8
 2**2
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
 22 __dyndbg      0000b9b8  0000000000000000  0000000000000000  00087878
 2**3
                  CONTENTS, ALLOC, LOAD, RELOC, DATA
 23 .data.unlikely 00000012  0000000000000000  0000000000000000
00093230  2**0
                  CONTENTS, ALLOC, LOAD, DATA

I'm using GCC 10.2.0, could this be the cause?

Thanks,
Qu




--7ejKiFIvzwU9aYummV4rTC4oQP8BckAvo--

--r0puDL8kytkufoMaAbP3T6qbmrRMWNN9l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9KB2UACgkQwj2R86El
/qhXNwgAkfGa4Y6TFnzKIp8Bp8pIcpYEj9Nf9WQcRNRjndTNZYHCxqqRTE7JLpge
LeuQ3ampCh49sY5UUOjE9lasOetA6+Jd4WTqU9BDI3KLfG+DvsSyz8cMqOPjwTSV
47bNyPc5X5bh575n/C5F3nQVyfpa7YP9zn9bk97fhnAVJyRyI0aA5WcgI1E+tvLG
FXB6UZSIoagIqFpoR1fh7xhjcX8pJDf1JsV2C79c/cK1LNl7SHlrwbxStomtG6PB
AuujnlYrwDwchJ/EsJYewixeNpp6W3IMGhPnHOrqlsE1mzVCET9ySAQtkYrsTO2A
bIlXNU1BQg3R4CXr0PbXgdU2bYf/JA==
=ladF
-----END PGP SIGNATURE-----

--r0puDL8kytkufoMaAbP3T6qbmrRMWNN9l--
