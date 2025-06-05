Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6424719CCF5
	for <linux-modules@vger.kernel.org>; Thu,  5 Jun 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112542; cv=none; b=G5E0lIdiWeJ5CW544S6G2cAcrCjzbzzY9QRdYLb5zbEuSkVjnYYPfIVptXEnoSbW0kc76xVxfitX2wwTcEhL+h5z6kYjLT1mmwxUIru5qoyCyqcfrXQG6tQKtPduiC6yV/knqdu8lPIe0Rc/WnO9pHZvPJtO0BODh7kyiJ4UTKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112542; c=relaxed/simple;
	bh=NRoDy9oPqPmwUYRp1IJc6lJX14zHgjomcJR0myjnx68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7yRfVOX9F9Mf336NNi5uVvxhxpiEFHPazbpPwNhPYcWuFURhXA85r2I6AUN0t7rilV2qnLxfn882Wgo+MKeSyacqYYhkGkLrCKJU7tvsDqLQ0XOzPCvGD5i9dVbropAqM5Xmdbf/L7BeE3e/EhCsZ7lQ34uvXvQu/leqLMaaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TREX2d0e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TREX2d0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749112539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J7OP291cCHEccCOVb5GqF2fJ19heqtSc19LUMzhHmhc=;
	b=TREX2d0erQu9XSW+R51sFiXxLM3oQQW2H9INe1UDuav+c5fF7QgdtIDuZVwZ3Topx8qqaE
	Ap+5ObyghbAQbx0hVqilReKEB4hgdRB6AIW/GxSEeJZcV+bHmNJlPOK/ve7cq/uo7lD90Q
	ZIBWahAmf3zaiVbePu+9NvgGJknns60=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-r5BhhtY6NCOx4Xzuc4w2RQ-1; Thu, 05 Jun 2025 04:35:37 -0400
X-MC-Unique: r5BhhtY6NCOx4Xzuc4w2RQ-1
X-Mimecast-MFC-AGG-ID: r5BhhtY6NCOx4Xzuc4w2RQ_1749112536
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74299055c3dso1307901b3a.0
        for <linux-modules@vger.kernel.org>; Thu, 05 Jun 2025 01:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749112536; x=1749717336;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7OP291cCHEccCOVb5GqF2fJ19heqtSc19LUMzhHmhc=;
        b=M2pjJjvK6NStLd8uP64WzgNrQujR2yzNRRRz+C0Wk9QoLGX8KVlsyI100iWpUliOQz
         zZznW+5u+PJw61POa+JEmndKjJDgpujFGsTPPJnn4ZGsVyYsgK6R+1u+PlJUKwi/dZaM
         s5tRgNIz5HIZhrfRUKtxQtRmUugwVMmd8w8fAYZMhphXMFS1WF8/wUVQrVw5ItyjXF8r
         X1Aa347tw9ZnskZQG9zaNQJpc9oxhGrxJOUT8az4HTEVcxqhms6r20OyVwhMSlXImm58
         ZXn02JDPwf5KL1H3HO4E6+Ot80jrlDUiQSLCoCzsxJ6PJdqJM8F/MX1L9ZeOg3aLULFk
         hrmg==
X-Forwarded-Encrypted: i=1; AJvYcCULJcihLnk4pHoJrCyndKFBTywd+BtAgwM6ZKDjSXzOSUWE2ZjsS4Vc4FHGMeYoJtK6Ya5zlX+aVFUTRDGb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb9SX3J0uGtU46Ih3NzJy+o2976BjGiVdZpTm7EFmewrFeuwZ1
	58infTO7G8RRPicYCeqrSthgDYSw+GkxJ1LID1duJST805iTtX/v4rEVUyjBKjLMQyt/RGqNn9e
	moK8GPIwKjeHMJxE2F/yZvAe6ySPr5xdBNsQ0P2BzerlBK9rTSr4SV1qMbpmmVkfK8x0=
X-Gm-Gg: ASbGncs9HOJJ16AsKIoUzTQ5Cmek8/0m59TZH90vhLDeUT1Cl5A5TerdEjYC4nn3nXF
	ioxmnIBq5g7MArwGtoA7HaWCT6+g621FFS4f1d8EcEK+UweoXkR5EPuY4iuGdkdvkLXmFo5frC0
	SNGdWoQIq1NKAbx7x33IGvnTGkbH7qmU/YF+FU5s6Ti9NwzxfiULkQNpkLZ0mVlvSHoQoDDC/r8
	X/mHODmfYns11HN6qYVvmgTrY0kYwkMGcRyjIDiMZ8GiZaN1tLIVmZcvq8FQMR4OdhbrxAS/nkH
	Qt0=
X-Received: by 2002:a05:6a00:23c6:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-7480b2e0361mr8190455b3a.12.1749112536507;
        Thu, 05 Jun 2025 01:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrN0PqOUdKalMaeAG7aIgHJtiglVXWjEwD24TEHI4LYox9Gd70kryUZzyeMjHmJRalEgOnRg==
X-Received: by 2002:a05:6a00:23c6:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-7480b2e0361mr8190429b3a.12.1749112536110;
        Thu, 05 Jun 2025 01:35:36 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeab75csm12734762b3a.52.2025.06.05.01.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 01:35:35 -0700 (PDT)
Date: Thu, 5 Jun 2025 16:34:20 +0800
From: Coiby Xu <coxu@redhat.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, keyrings@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Peter Jones <pjones@redhat.com>, Robert Holmes <robeholmes@gmail.com>, 
	Jeremy Cline <jcline@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RFC 1/1] module: Make use of platform keyring for module
 signature verify
Message-ID: <ibosm332sa2kz6vqrru5qsfk4tybsxepo4vascc3zsetmyckvv@pml7puc5jyl6>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <20250602132535.897944-2-vkuznets@redhat.com>
 <948f5567fe4d9ae39aa2528965f123e42bf82b46.camel@HansenPartnership.com>
 <87r001yzob.fsf@redhat.com>
 <d34555e2b0c4746fc01d5295959a434befcf8b18.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d34555e2b0c4746fc01d5295959a434befcf8b18.camel@HansenPartnership.com>

On Tue, Jun 03, 2025 at 09:03:22AM -0400, James Bottomley wrote:
>On Tue, 2025-06-03 at 10:52 +0200, Vitaly Kuznetsov wrote:
>> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
>[...]
>> > Also, are you sure a config option is the right thing?  Presumably
>> > Red Hat wants to limit its number of kernels and the design of just
>> > linking the machine keyring (i.e. MoK) was for the use case where
>> > trust is being pivoted away from db by shim, so users don't want to
>> > trust the db keys they don't control.  If the same kernel gets used
>> > for both situations (trusted and untrusted db) you might want a
>> > runtime means to distinguish them.
>>
>> I was not personally involved when RH put the patch downstream (and
>> wasn't very successful in getting the background story) but it
>> doesn't even have an additional Kconfig, e.g.:
>> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-10/-/commit/03d4694fa6511132989bac0da11fa677ea5d29f6
>> so apparently there's no desire to limit anything, basically,
>> .platform is always trusted on Fedora/RHEL systems (for a long time
>> already).
>
>It sounds like that's just distro politics:  RH wants to enable binary
>modules (by allowing them to be signed) but doesn't want to be seen to
>be signing them (so they can't be signed with the embedded RH key) so
>that gamers can have performant graphics drivers and the like.  Thus it
>mixes in the db keyring, which usually contains several Microsoft
>certificates and also one from the ODM manufacturer, so now it can send
>would be shippers of binary modules to those groups to get them signed.
>If you only have the built in and MoK keyrings, the only possible
>signers are either RH or the machine owner ... who isn't a single
>entity to deal with.  Personally I think this is a bit daft: Debian
>manages an out of tree module infrastructure using DKMS and MoK
>signing, so I can't see why RH can't get it to work in the same way.

It's interesting to find that although Debian's wiki page [1] only
mentions DKMS and MOK, it actually has the same downstream kernel patch
[2][3] as Fedora/RHEL to allow using db keys to verify kernel modules.

[1] https://wiki.debian.org/SecureBoot
[2] https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/patches/features/all/db-mok-keyring/KEYS-Make-use-of-platform-keyring-for-module-signature.patch?ref_type=heads
[3] https://sources.debian.org/patches/linux/6.12.30-1/features/all/db-mok-keyring/KEYS-Make-use-of-platform-keyring-for-module-signature.patch/

-- 
Best regards,
Coiby

