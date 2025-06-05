Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46315748F
	for <linux-modules@vger.kernel.org>; Thu,  5 Jun 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135367; cv=none; b=Y3F1QL0Eev6IbYF+OnUAgFVxWXinIenO0UJFnh3OB9f6WdH2JqzaVvgHipHz1mp9GBmDBpRsi7RbvId392am2QYPyLRSGeb1Of3X2ANEQsko7BnNDKXa2ra3qwtbvaxXekEVxX9peDrubuisDDQUiwuXVD+vbgyFpwGJBDyAPjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135367; c=relaxed/simple;
	bh=DHu18rmA0sU7oZNUXhtODTBETFCDhL2OEUU38uuVFxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LwO5QYm0ebHRnmoy52M8lhHdKibI5QURq4yN1mKNuhUTBoLbqr1RlW7PbnNvjV0yThnhffNUZ5k47oQ7sVXjfYcU9xr3q0WhkGzzJ+uRlReMB4N3s5Hybuqbi+I1mcLXoYzhc4ZqZ9q4OBKoGSc2wz7+dYYZxQqiwStszWzkjyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-4k9GuALlMsSlz6K-iKOB-w-1; Thu, 05 Jun 2025 10:56:04 -0400
X-MC-Unique: 4k9GuALlMsSlz6K-iKOB-w-1
X-Mimecast-MFC-AGG-ID: 4k9GuALlMsSlz6K-iKOB-w_1749135363
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-440667e7f92so7921345e9.3
        for <linux-modules@vger.kernel.org>; Thu, 05 Jun 2025 07:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749135363; x=1749740163;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFA6j3WG2u6wCRFKF+JPzUGEfqC8djtrecvjhVi86Lo=;
        b=FY6pUEpO2Mu5u97IcDMnwOOd5np0he58i+tH7/fp1TDlUmXmo2LWnkernbmCa6itbR
         HGZpmEz3zXr+56v4/9kDPc1sZSg6CXCf0YjbQQDYn9fGtY5MWGRFSBBeMz3/kARDHVyP
         eXvUTof7lyMklgcR228x+jviEoyd/KpsdrjyqB+X50S8OrL6Y7Fo8WWGNxggb8DbBcVS
         jQ5/HjD+CcypuJqysXBDisv0OacEaJQOOXB96sPFw9FUh2Xa/hyZ9ex6hwRC1uiRRamM
         x4+fLnmZ11pkAwEycbMX6aI2qjMsrM3pDsXf0AjELYJLTlF+zrWLAQzKu0+oROcHrNqb
         Yb9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNZIknX5/Bweu/NxId5sP1Xr2gTW4+9629q2Dl+r4AcOeWYrbHc1TjrSfAWLDxIowsDAqkCrkq5yihtIpD@vger.kernel.org
X-Gm-Message-State: AOJu0YxRinMv6EPGfBCC/Sv+HnIe6eMLr9rrx5C+te0wExP7kJkbvHDK
	tit4Di4R8DcI5oQIyS2E85GIKVyLhgUCuCsPB6LTGGvwDWsV+2Hj3hsg/H9T4488ck2YQYQK8tL
	zKmWQSMze0O57W76VMHV4zzaDb2axI5crLQR+1fhVZorb/PO4SRSq2vyL9WeZGRsSxC0=
X-Gm-Gg: ASbGncugGbVpdhOcvfVwTGyhIuxAGHxNfoGCjf2Evd+NgiwNbgxeQd5cNVqjVjQmndB
	hfqd1M83CIJR6G6w8ZnCLR5A2VMDTCIKLdslXzkVZDieVZkHY3+w/3TBmdVIW5buFH2bjM2PQcZ
	DRocfEQnXwxjZlDRQAxXNKRoDDTar3TB2HGiFmOptq4isRDbvztSK2zqaSmDyqp8tlB3OFsPjwn
	eIAmHma22IMjpk2o50yn565RBF9waG1MqyZsaPVmJPDhb9M8Nwv4xddADVJCZwVn/pFBaL376L9
	lYXtZHA=
X-Received: by 2002:adf:e38c:0:b0:3a5:2670:e220 with SMTP id ffacd0b85a97d-3a52670e28dmr3061232f8f.32.1749135362777;
        Thu, 05 Jun 2025 07:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA81c6wZglVzh0Z3/rZiV4JQo/XmLeKsTiTnUWO5wj0USvJJ+iJpt9siQ/hlalGpRgG5o3Zw==
X-Received: by 2002:adf:e38c:0:b0:3a5:2670:e220 with SMTP id ffacd0b85a97d-3a52670e28dmr3061215f8f.32.1749135362368;
        Thu, 05 Jun 2025 07:56:02 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cfe3sm27314005e9.23.2025.06.05.07.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:56:02 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-modules@vger.kernel.org"
 <linux-modules@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, David Howells <dhowells@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami
 Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Peter Jones <pjones@redhat.com>, Robert
 Holmes <robeholmes@gmail.com>, Jeremy Cline <jcline@redhat.com>, Coiby Xu
 <coxu@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RFC 0/1] module: Optionally use .platform keyring for
 signatures verification
In-Reply-To: <435F53C6-DC08-49CA-AA36-9747FC1B50DF@oracle.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <0FD18D05-6114-4A25-BD77-C32C1D706CC3@oracle.com>
 <f0b37bc55ed3c02569c74f0fbdb6afa8efd329e2.camel@HansenPartnership.com>
 <87zfemoc76.fsf@redhat.com>
 <435F53C6-DC08-49CA-AA36-9747FC1B50DF@oracle.com>
Date: Thu, 05 Jun 2025 16:56:00 +0200
Message-ID: <87qzzynsov.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Snowberg <eric.snowberg@oracle.com> writes:

>> On Jun 5, 2025, at 1:54=E2=80=AFAM, Vitaly Kuznetsov <vkuznets@redhat.co=
m> wrote:
>>=20
>> 'certwrapper' offers _a_ solution which is great. It may, however, not
>> be very convenient to use when a user wants to re-use the same OS image
>> (e.g. provided by the distro vendor) for various different use-cases as
>> proper 'certwrapper' binary needs to be placed on the ESP (and thus
>> we'll end up with a bunch of images instead of one). 'db' is different
>> because it normally lives outside of the OS disk so it is possible to
>> register the exact same OS image with different properties (e.g. with
>> and without a custom cert which allows to load third party modules).
>
> Could you please provide more details? The kernel module is signed with=20
> a specific key. The =E2=80=98db=E2=80=99  key in the cloud image must mat=
ch whatever key=20
> was used to sign the kernel module.
>
> Why can=E2=80=99t the RPM package that contains the kernel module also in=
clude=20
> the required =E2=80=98certwrapper=E2=80=99?  When the RPM is installed, t=
he appropriate=20
> =E2=80=98certwrapper=E2=80=99 is placed on the ESP.  There can be any num=
ber of 'certwrappers'=20
> in the ESP. Doesn=E2=80=99t this solution address the issue?

I think it does but let me elaborate on where I believe some (minor?)
inconvenience comes from.

We have various actors here:
1) The OS image which is coming from a distro vendor.

2) The user, which takes the OS image and registers it with specific
properties (including 'db') with various infrastructures (e.g. different
clouds).

3) A third party kmod vendor which produces a module compatible with the
OS version. The module may only make sense for certain VMs on certain
clouds.

The customization of the VM normally happens upon first boot: a generic
image from the OS vendor (1) boots and then some provisioning agent
(cloud-init, WALA,...) takes over and e.g. installs additional
stuff. This additional stuff may include third party kmods from (3).

The 'certwrapper' must carry the key which the third party vendor (3) uses
and it must be signed by a key which the user (2) put to the 'db'. If we
want to have the 'certwrapper' shipped inside the same RPM as the kernel
module, it will be signed by the same third party vendor (3). While this
looks a bit weird ('self-signed certwrapper'), I don't see why this
can't work.=20

Besides the need to teach (3) how to build certwrappers, an inconvenience
in this scheme comes from the fact that to activate a 'certwrapper'
which we install from a custom rpm, we need a reboot. Cloud instances
often back burstable workloads and this can be seen as annoyance.

--=20
Vitaly

