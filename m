Return-Path: <SRS0=+TOZ=P6=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0DFC282C3
	for <linux-modules@archiver.kernel.org>; Tue, 22 Jan 2019 20:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279D021726
	for <linux-modules@archiver.kernel.org>; Tue, 22 Jan 2019 20:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJVcrA5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfAVUoA (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:44:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52283 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVUoA (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 22 Jan 2019 15:44:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so15567675wml.2
        for <linux-modules@vger.kernel.org>; Tue, 22 Jan 2019 12:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vaaLoBMsSscOeZ7+4aK8O2l+5xZPmgqgXrSWx/MFSR4=;
        b=MJVcrA5VQ9RoOO0oXxGparpakZiJU+skIxxveUMQ/Xaqkc/6RLYFQwa52FQ6qeXRAI
         r8FjNy+u5iTjYSuVPdBqAF7eXrGT7JI21Wq6efZW32C/6hWRAuLq+dBA8Xid7sJgNCCQ
         IcQShafI5eOkGEfFzjRWFp7tiXdbDf/Puvf287Sv4jKZpmoK08V21MInGWhxRTruI5rJ
         CyTD2Nxs6v0ulWM/dsrWf1oLb32fdXgxbHrY02LcsnEhfegZnuMyhXhzTxcOny7KNsOE
         VTEIGKc7cC7gwk7r2yKci1jZFZK0iZ3nIr/xqThJJLSpuKNJRmqd4d4zdVJ+z1MjAZKl
         4GLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vaaLoBMsSscOeZ7+4aK8O2l+5xZPmgqgXrSWx/MFSR4=;
        b=j5AoM7QUx5sAEObZGiUguenLjasMlsIJGqPJ5de3Qhve+cGzfZknJhOkbe0CIypwxd
         bZ0sMecRuwtrh4KcDOe1HC5qBVl4GElXSdW2p7VTeEvS/URRETSm0bdlmOaicZhVMAbm
         CBXQyQEWFInQCZs0AilmYvO/1jn3rbll5S2RBUEDwcA92oObFCLokPAD1uRPIGeVmMUw
         +UWQi0ntBtHhkeUVLZg/qWXi0q5G33jZB3bYa4XYUSmKYyTXrcVRzkhH3gqth3cH8Qj4
         S4vA3uTXxuCciuEVEmJvqw+eUCHhCpV3fRQGOikT/K/K5yb+7aIZ9u4Wn///n+y1EqBE
         lkHg==
X-Gm-Message-State: AJcUuker2z8iCGoS1daP8pZjBV3Of5FXU5Pnqh9q//RNjD2So4ip4C8g
        M0BxLefskVHKsysZb4zuQIyuj8Djeg9mCq+1f28=
X-Google-Smtp-Source: ALg8bN6w89QGkNjeANyuzfGiJ2GB/VpyQc/XO6TbkVLfUCQ08yEX6311KUYlU6z6+kpngEUfJ8oqNwH5KR3zjWYBYRw=
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr16505wme.119.1548189836964;
 Tue, 22 Jan 2019 12:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20180308135810.4309-1-yauheni.kaliuta@redhat.com>
 <xunyva2gfon3.fsf@redhat.com> <20190122210351.4484098d@kitsune.suse.cz>
In-Reply-To: <20190122210351.4484098d@kitsune.suse.cz>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Tue, 22 Jan 2019 12:43:45 -0800
Message-ID: <CAKi4VALJcbwq2SKpb3fBw022gBO1kBe0qL9=Vszg2OOBps+dtA@mail.gmail.com>
Subject: Re: [PATCH RFC PKCS7 asn1c 0/2] asn1c version of PKCS#7 parser
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        linux-modules <linux-modules@vger.kernel.org>,
        Ferry van Steen <Ferry.van.Steen@citrus.nl>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Jan 22, 2019 at 12:03 PM Michal Such=C3=A1nek <msuchanek@suse.de> w=
rote:
>
> On Tue, 22 Jan 2019 22:01:04 +0200
> Yauheni Kaliuta <yauheni.kaliuta@redhat.com> wrote:
>
> > Hi!
> >
> > Looks like OpenSUSE took the RFC patch.
> >
> > The diverging doesn't sound nice, frankly speaking.
>
> Is there an upstream solution?
>
> The diverging is caused by lack of support upstream.

Mea culpa for not deciding with which implementation to go for the
next release. We actually have 3 possible implementations: one with
openssl, one with gnutls and
this one lifting the implementation from the kernel to be used in userspace=
.

It would be good to know from downstream their preference to weigh in
the decision.

Yauheni, as the one implementing all of them, which one do you think
is the most future-proof?
Sorry for the long time in getting this in.

Lucas De Marchi


>
> Thanks
>
> Michal
>
> >
> > >>>>> On Thu, 08 Mar 2018 06:58:08 -0700, Yauheni Kaliuta  wrote:
> >
> >  > Draft implementation of possible PKCS7 signature parser for
> >  > modinfo.  I'm pretty bad in autotools, so would be fine if
> >  > somebody integrate it inside properly.
> >
> >  > What bothers me is that asn1c files are generated under BSD
> >  > license.
> >
> >  > Yauheni Kaliuta (2):
> >  >   libkmod-signature: implement pkcs7 parsing with asn1c compiler
> >  >   libkmod, pkcs7: commit asn1c autogenerated files
> >
> >  >  Makefile.am                                        |   22 +-
> >  >  configure.ac                                       |    1 +
> >  >  libkmod/libkmod-internal.h                         |    3 +
> >  >  libkmod/libkmod-module.c                           |    3 +
> >  >  libkmod/libkmod-signature.c                        |  105 +-
> >  >  libkmod/pkcs7/asn1c-gen/ANY.c                      |  158 ++
> >  >  libkmod/pkcs7/asn1c-gen/ANY.h                      |   48 +
> >  >  libkmod/pkcs7/asn1c-gen/AttributeValueAssertion.c  |   68 +
> >  >  libkmod/pkcs7/asn1c-gen/AttributeValueAssertion.h  |   40 +
> >  >  libkmod/pkcs7/asn1c-gen/AuthenticatedAttribute.c   |   69 +
> >  >  libkmod/pkcs7/asn1c-gen/AuthenticatedAttribute.h   |   40 +
> >  >  libkmod/pkcs7/asn1c-gen/BIT_STRING.c               |  189 ++
> >  >  libkmod/pkcs7/asn1c-gen/BIT_STRING.h               |   33 +
> >  >  libkmod/pkcs7/asn1c-gen/CRLSequence.c              |   52 +
> >  >  libkmod/pkcs7/asn1c-gen/CRLSequence.h              |   44 +
> >  >  libkmod/pkcs7/asn1c-gen/Certificate.c              |  104 ++
> >  >  libkmod/pkcs7/asn1c-gen/Certificate.h              |   39 +
> >  >  libkmod/pkcs7/asn1c-gen/CertificateList.c          |   52 +
> >  >  libkmod/pkcs7/asn1c-gen/CertificateList.h          |   39 +
> >  >  .../pkcs7/asn1c-gen/CertificateRevocationLists.c   |   52 +
> >  >  .../pkcs7/asn1c-gen/CertificateRevocationLists.h   |   44 +
> >  >  libkmod/pkcs7/asn1c-gen/CertificateSerialNumber.c  |  109 ++
> >  >  libkmod/pkcs7/asn1c-gen/CertificateSerialNumber.h  |   39 +
> >  >  libkmod/pkcs7/asn1c-gen/Certificates.c             |   52 +
> >  >  libkmod/pkcs7/asn1c-gen/Certificates.h             |   39 +
> >  >  libkmod/pkcs7/asn1c-gen/ContentInfo.c              |   69 +
> >  >  libkmod/pkcs7/asn1c-gen/ContentInfo.h              |   40 +
> >  >  libkmod/pkcs7/asn1c-gen/ContentType.c              |  109 ++
> >  >  libkmod/pkcs7/asn1c-gen/ContentType.h              |   39 +
> >  >  libkmod/pkcs7/asn1c-gen/Data.c                     |  104 ++
> >  >  libkmod/pkcs7/asn1c-gen/Data.h                     |   39 +
> >  >  .../pkcs7/asn1c-gen/DigestAlgorithmIdentifier.c    |   68 +
> >  >  .../pkcs7/asn1c-gen/DigestAlgorithmIdentifier.h    |   40 +
> >  >  .../pkcs7/asn1c-gen/DigestAlgorithmIdentifiers.c   |  153 ++
> >  >  .../pkcs7/asn1c-gen/DigestAlgorithmIdentifiers.h   |   68 +
> >  >  .../DigestEncryptionAlgorithmIdentifier.c          |   68 +
> >  >  .../DigestEncryptionAlgorithmIdentifier.h          |   40 +
> >  >  libkmod/pkcs7/asn1c-gen/EncryptedDigest.c          |  109 ++
> >  >  libkmod/pkcs7/asn1c-gen/EncryptedDigest.h          |   39 +
> >  >  .../ExtendedCertificatesAndCertificates.c          |   52 +
> >  >  .../ExtendedCertificatesAndCertificates.h          |   39 +
> >  >  libkmod/pkcs7/asn1c-gen/INTEGER.c                  | 1025 +++++++++=
++
> >  >  libkmod/pkcs7/asn1c-gen/INTEGER.h                  |   82 +
> >  >  libkmod/pkcs7/asn1c-gen/IssuerAndSerialNumber.c    |   65 +
> >  >  libkmod/pkcs7/asn1c-gen/IssuerAndSerialNumber.h    |   39 +
> >  >  libkmod/pkcs7/asn1c-gen/Makefile.am                |  131 ++
> >  >  libkmod/pkcs7/asn1c-gen/Makefile.am.sample         |  150 ++
> >  >  libkmod/pkcs7/asn1c-gen/Name.c                     |   52 +
> >  >  libkmod/pkcs7/asn1c-gen/Name.h                     |   44 +
> >  >  libkmod/pkcs7/asn1c-gen/NativeEnumerated.c         |  207 +++
> >  >  libkmod/pkcs7/asn1c-gen/NativeEnumerated.h         |   32 +
> >  >  libkmod/pkcs7/asn1c-gen/NativeInteger.c            |  332 ++++
> >  >  libkmod/pkcs7/asn1c-gen/NativeInteger.h            |   37 +
> >  >  libkmod/pkcs7/asn1c-gen/OBJECT_IDENTIFIER.c        |  764 +++++++++
> >  >  libkmod/pkcs7/asn1c-gen/OBJECT_IDENTIFIER.h        |  139 ++
> >  >  libkmod/pkcs7/asn1c-gen/OCTET_STRING.c             | 1807 +++++++++=
+++++++++++
> >  >  libkmod/pkcs7/asn1c-gen/OCTET_STRING.h             |   86 +
> >  >  libkmod/pkcs7/asn1c-gen/PKCS7ContentInfo.c         |   69 +
> >  >  libkmod/pkcs7/asn1c-gen/PKCS7ContentInfo.h         |   45 +
> >  >  .../pkcs7/asn1c-gen/RelativeDistinguishedName.c    |   52 +
> >  >  .../pkcs7/asn1c-gen/RelativeDistinguishedName.h    |   44 +
> >  >  .../pkcs7/asn1c-gen/SetOfAuthenticatedAttribute.c  |   52 +
> >  >  .../pkcs7/asn1c-gen/SetOfAuthenticatedAttribute.h  |   44 +
> >  >  libkmod/pkcs7/asn1c-gen/SignedData.c               |  227 +++
> >  >  libkmod/pkcs7/asn1c-gen/SignedData.h               |   81 +
> >  >  libkmod/pkcs7/asn1c-gen/SignerIdentifier.c         |   65 +
> >  >  libkmod/pkcs7/asn1c-gen/SignerIdentifier.h         |   50 +
> >  >  libkmod/pkcs7/asn1c-gen/SignerInfo.c               |  371 ++++
> >  >  libkmod/pkcs7/asn1c-gen/SignerInfo.h               |  107 ++
> >  >  libkmod/pkcs7/asn1c-gen/SignerInfos.c              |  153 ++
> >  >  libkmod/pkcs7/asn1c-gen/SignerInfos.h              |   68 +
> >  >  libkmod/pkcs7/asn1c-gen/SubjectKeyIdentifier.c     |  109 ++
> >  >  libkmod/pkcs7/asn1c-gen/SubjectKeyIdentifier.h     |   39 +
> >  >  libkmod/pkcs7/asn1c-gen/UnauthenticatedAttribute.c |   69 +
> >  >  libkmod/pkcs7/asn1c-gen/UnauthenticatedAttribute.h |   40 +
> >  >  libkmod/pkcs7/asn1c-gen/Values.c                   |   52 +
> >  >  libkmod/pkcs7/asn1c-gen/Values.h                   |   39 +
> >  >  libkmod/pkcs7/asn1c-gen/asn_SEQUENCE_OF.c          |   41 +
> >  >  libkmod/pkcs7/asn1c-gen/asn_SEQUENCE_OF.h          |   52 +
> >  >  libkmod/pkcs7/asn1c-gen/asn_SET_OF.c               |   88 +
> >  >  libkmod/pkcs7/asn1c-gen/asn_SET_OF.h               |   62 +
> >  >  libkmod/pkcs7/asn1c-gen/asn_application.h          |   47 +
> >  >  libkmod/pkcs7/asn1c-gen/asn_codecs.h               |  109 ++
> >  >  libkmod/pkcs7/asn1c-gen/asn_codecs_prim.c          |  312 ++++
> >  >  libkmod/pkcs7/asn1c-gen/asn_codecs_prim.h          |   53 +
> >  >  libkmod/pkcs7/asn1c-gen/asn_internal.h             |  128 ++
> >  >  libkmod/pkcs7/asn1c-gen/asn_system.h               |  137 ++
> >  >  libkmod/pkcs7/asn1c-gen/ber_decoder.c              |  283 +++
> >  >  libkmod/pkcs7/asn1c-gen/ber_decoder.h              |   64 +
> >  >  libkmod/pkcs7/asn1c-gen/ber_tlv_length.c           |  178 ++
> >  >  libkmod/pkcs7/asn1c-gen/ber_tlv_length.h           |   50 +
> >  >  libkmod/pkcs7/asn1c-gen/ber_tlv_tag.c              |  144 ++
> >  >  libkmod/pkcs7/asn1c-gen/ber_tlv_tag.h              |   60 +
> >  >  libkmod/pkcs7/asn1c-gen/constr_CHOICE.c            | 1114 +++++++++=
+++
> >  >  libkmod/pkcs7/asn1c-gen/constr_CHOICE.h            |   57 +
> >  >  libkmod/pkcs7/asn1c-gen/constr_SEQUENCE.c          | 1425 +++++++++=
++++++
> >  >  libkmod/pkcs7/asn1c-gen/constr_SEQUENCE.h          |   60 +
> >  >  libkmod/pkcs7/asn1c-gen/constr_SEQUENCE_OF.c       |  208 +++
> >  >  libkmod/pkcs7/asn1c-gen/constr_SEQUENCE_OF.h       |   33 +
> >  >  libkmod/pkcs7/asn1c-gen/constr_SET_OF.c            |  954 +++++++++=
++
> >  >  libkmod/pkcs7/asn1c-gen/constr_SET_OF.h            |   42 +
> >  >  libkmod/pkcs7/asn1c-gen/constr_TYPE.c              |   77 +
> >  >  libkmod/pkcs7/asn1c-gen/constr_TYPE.h              |  180 ++
> >  >  libkmod/pkcs7/asn1c-gen/constraints.c              |   93 +
> >  >  libkmod/pkcs7/asn1c-gen/constraints.h              |   63 +
> >  >  libkmod/pkcs7/asn1c-gen/converter-sample.c         |  834 +++++++++
> >  >  libkmod/pkcs7/asn1c-gen/der_encoder.c              |  201 +++
> >  >  libkmod/pkcs7/asn1c-gen/der_encoder.h              |   68 +
> >  >  libkmod/pkcs7/asn1c-gen/per_decoder.c              |   93 +
> >  >  libkmod/pkcs7/asn1c-gen/per_decoder.h              |   56 +
> >  >  libkmod/pkcs7/asn1c-gen/per_encoder.c              |  151 ++
> >  >  libkmod/pkcs7/asn1c-gen/per_encoder.h              |   69 +
> >  >  libkmod/pkcs7/asn1c-gen/per_opentype.c             |  378 ++++
> >  >  libkmod/pkcs7/asn1c-gen/per_opentype.h             |   22 +
> >  >  libkmod/pkcs7/asn1c-gen/per_support.c              |  483 ++++++
> >  >  libkmod/pkcs7/asn1c-gen/per_support.h              |  135 ++
> >  >  libkmod/pkcs7/asn1c-gen/xer_decoder.c              |  368 ++++
> >  >  libkmod/pkcs7/asn1c-gen/xer_decoder.h              |  106 ++
> >  >  libkmod/pkcs7/asn1c-gen/xer_encoder.c              |   67 +
> >  >  libkmod/pkcs7/asn1c-gen/xer_encoder.h              |   59 +
> >  >  libkmod/pkcs7/asn1c-gen/xer_support.c              |  227 +++
> >  >  libkmod/pkcs7/asn1c-gen/xer_support.h              |   55 +
> >  >  libkmod/pkcs7/pkcs7.asn1                           |  135 ++
> >  >  libkmod/pkcs7/pkcs7_parser.c                       |  297 ++++
> >  >  libkmod/pkcs7/pkcs7_parser.h                       |   42 +
> >  >  125 files changed, 19228 insertions(+), 20 deletions(-)
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/ANY.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/ANY.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/AttributeValueAssertion.=
c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/AttributeValueAssertion.=
h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/AuthenticatedAttribute.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/AuthenticatedAttribute.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/BIT_STRING.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/BIT_STRING.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/CRLSequence.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/CRLSequence.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/Certificate.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/Certificate.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/CertificateList.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/CertificateList.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/CertificateRevocationLis=
ts.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/CertificateRevocationLis=
ts.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/CertificateSerialNumber.=
c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/CertificateSerialNumber.=
h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/Certificates.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/Certificates.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/ContentInfo.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/ContentInfo.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/ContentType.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/ContentType.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/Data.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/Data.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/DigestAlgorithmIdentifie=
r.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/DigestAlgorithmIdentifie=
r.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/DigestAlgorithmIdentifie=
rs.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/DigestAlgorithmIdentifie=
rs.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/DigestEncryptionAlgorith=
mIdentifier.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/DigestEncryptionAlgorith=
mIdentifier.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/EncryptedDigest.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/EncryptedDigest.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/ExtendedCertificatesAndC=
ertificates.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/ExtendedCertificatesAndC=
ertificates.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/INTEGER.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/INTEGER.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/IssuerAndSerialNumber.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/IssuerAndSerialNumber.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/Makefile.am
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/Makefile.am.sample
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/Name.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/Name.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/NativeEnumerated.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/NativeEnumerated.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/NativeInteger.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/NativeInteger.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/OBJECT_IDENTIFIER.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/OBJECT_IDENTIFIER.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/OCTET_STRING.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/OCTET_STRING.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/PKCS7ContentInfo.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/PKCS7ContentInfo.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/RelativeDistinguishedNam=
e.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/RelativeDistinguishedNam=
e.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/SetOfAuthenticatedAttrib=
ute.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/SetOfAuthenticatedAttrib=
ute.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/SignedData.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/SignedData.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/SignerIdentifier.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/SignerIdentifier.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/SignerInfo.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/SignerInfo.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/SignerInfos.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/SignerInfos.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/SubjectKeyIdentifier.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/SubjectKeyIdentifier.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/UnauthenticatedAttribute=
.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/UnauthenticatedAttribute=
.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/Values.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/Values.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/asn_SEQUENCE_OF.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/asn_SEQUENCE_OF.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/asn_SET_OF.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/asn_SET_OF.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/asn_application.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/asn_codecs.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/asn_codecs_prim.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/asn_codecs_prim.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/asn_internal.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/asn_system.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/ber_decoder.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/ber_decoder.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/ber_tlv_length.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/ber_tlv_length.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/ber_tlv_tag.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/ber_tlv_tag.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/constr_CHOICE.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/constr_CHOICE.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/constr_SEQUENCE.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/constr_SEQUENCE.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/constr_SEQUENCE_OF.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/constr_SEQUENCE_OF.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/constr_SET_OF.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/constr_SET_OF.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/constr_TYPE.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/constr_TYPE.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/constraints.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/constraints.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/converter-sample.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/der_encoder.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/der_encoder.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/per_decoder.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/per_decoder.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/per_encoder.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/per_encoder.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/per_opentype.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/per_opentype.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/per_support.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/per_support.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/xer_decoder.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/xer_decoder.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/xer_encoder.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/xer_encoder.h
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/xer_support.c
> >  >  create mode 100644 libkmod/pkcs7/asn1c-gen/xer_support.h
> >  >  create mode 100644 libkmod/pkcs7/pkcs7.asn1
> >  >  create mode 100644 libkmod/pkcs7/pkcs7_parser.c
> >  >  create mode 100644 libkmod/pkcs7/pkcs7_parser.h
> >
> >  > --
> >  > 2.16.2
> >
> >  > --
> >  > To unsubscribe from this list: send the line "unsubscribe linux-modu=
les" in
> >  > the body of a message to majordomo@vger.kernel.org
> >  > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>


--=20
Lucas De Marchi
