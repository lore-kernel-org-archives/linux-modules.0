Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357502566FC
	for <linux-modules@vger.kernel.org>; Sat,  1 Nov 2025 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762015831; cv=none; b=o6Sz6gs044GjqZzB/bV+LQFr1SZEYMRnro3wNFUXcPpiL9I/JX3js6JesiiEmppQFYIbqn/vI1qziS0Y3PALuj2z1nBr1qHKBwvkzas/V9SaZGIevXXBJHPzQVneIMMMioytOFrnVJjOMhiMfAncNUWpoY9kmcTf/ZaciWPKPP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762015831; c=relaxed/simple;
	bh=FrZal8yYbhzhsqba5frY/Ttn5N1pNqoOnzgHhUFgsMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbJMULZGjMzPJPamZJxLmRC80xtclsL9wWLsex/mK94lyFVvGrtvsBWp7zDNjMPHrZY9wOKvY/G7tOTP7Yyz4E7jsIM162CrbMN5W8bQr1hTUgfow74KVn0gAX/vy5rLaLqcaU1k5OvXUyuKyYRjhYWhM7ovFoH03hAcv6fhl7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YRqeDycH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YRqeDycH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29555415c5fso9296125ad.1
        for <linux-modules@vger.kernel.org>; Sat, 01 Nov 2025 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762015829; x=1762620629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp7Jl4nag3DStXHFmy5x4RJxSYwbRYZWfeoPk0Z1FdM=;
        b=YRqeDycHaZhIN5PFnK4dy7UP8uzbp+z9HIUt7ljqP36Cyrug+jdLLAW7SyOqqKqeXY
         rS7nhw9YtCXiEqvwxrGd70H1irWo1+ZN1evlgcTMPNi5B4tlu944C3qQSJNN61i6iKmG
         nXPwRUlpVYfEaaDBk57akMhV/ZArZGqy29gi4PNulfqXB6m6rEQEMxC0SrKJrNeLx/v6
         qugSgQpcphkxX9oltRD4s/oDDDdcUqi22KX6nfFlHGPz90D1Dwx4Ryy7mvP06kSCPZPi
         VztLTPQCEbCNdONUx6Vsq1RpCtIxpQJ1cJnuL9qgoC7j67GmVyQ7z3k7N0B1iDFnYP1b
         WNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762015829; x=1762620629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bp7Jl4nag3DStXHFmy5x4RJxSYwbRYZWfeoPk0Z1FdM=;
        b=hUDujX2NAZywc2QAejN9IJO/ZeWCiWVJOe4y2n5tAIq9th0UmJaKeISyFORZhLRRoc
         odnmC4yGVu9GC2l/tanx8do53ZVEleaeoFXKeTTjsjlD7sUNZCQrDm4FmsQhBbL2ro5D
         h8dbiLJDEEeC3HFWGs0Y4kLUcsx1s0Y1rMFWWxHewqVBb1wsx62+k8XiuhRma2kA6Pwc
         Ns2kf+jujVvacfaL/WamjiqcsljYWErY5nK7lWDDd6t3V+6CRivcKovNO5goPIvEzSkX
         QpKnBhkANrtUUav+uRGWux4s/3BuTUQeNYl1kqxx6/1sjnkobNmsSvkATB7eLE03xLBh
         zZog==
X-Forwarded-Encrypted: i=1; AJvYcCUQHwBw2+uCFG4BtIWkfhOmd4jbKx+sdrvp82SjFGr6K6WLNgmu1g7smJdj0k47Zq8ceAUTd2DUOLr6cZec@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4vVY25tN0Pl3ekI/o3LUmzcwO01mOqBKpum74ChprY+GQBFh
	RGRaDTxp/zNedeRARwc+ofYrSTSpsGY0VcNtXEYUsLEUU3kpssB7hE4YGCVA4WSZ1bisBQnL6q8
	bbeUlFUOd0sedIjuvgJ5kvivzuJ88xaUfBX+x8uS5
X-Gm-Gg: ASbGncu8t6+k89NU+EjA7cIYAbVIekaroAzDipCXJYAnEVvhq72ibe0L2tJCaDvdLwo
	BF8hmDHfYolPgMQyFiNlfW/y+AXxL/lBlzte1O/QUJAnVH6sQ3+yL4YbWtXzBWuYmdSwPf5XrG3
	/gf0/tRD9nTSVjx5i7N24AmLZXAXPVJHViTFzBOB6Qt+FcQhXlDvOJCAsjTsw64/7IWbr3t4Y7n
	1zIu/4wQYPoOjdM0x0sKfB2tvAFpKoaFg9TdLSgRW3LUfsys99m42HnPtzh
X-Google-Smtp-Source: AGHT+IHGijQbi+tomijPm2MPmULn9ARXU/qQz78D1sD7VMsvT34ubDiuy2yifmGOLfXxnQ5Nim7WUvnCt0/4MQKGGiQ=
X-Received: by 2002:a17:902:f549:b0:272:2bf1:6a21 with SMTP id
 d9443c01a7336-2951a3be7a3mr93762465ad.14.1762015829557; Sat, 01 Nov 2025
 09:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928030358.3873311-1-coxu@redhat.com> <20251031074016.1975356-1-coxu@redhat.com>
In-Reply-To: <20251031074016.1975356-1-coxu@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 1 Nov 2025 12:50:18 -0400
X-Gm-Features: AWmQ_bnZC2lmPA3q2pkaCD57BVH_NwJj88l6NgpYnQnpCwtni8T6GO_HiPsWKoo
Message-ID: <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook security_kernel_module_read_file
 to access decompressed kernel module
To: Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Karel Srot <ksrot@redhat.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 3:41=E2=80=AFAM Coiby Xu <coxu@redhat.com> wrote:
>
> Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPRESS)
> is enabled, IMA has no way to verify the appended module signature as it
> can't decompress the module.
>
> Define a new LSM hook security_kernel_module_read_file which will be
> called after kernel module decompression is done so IMA can access the
> decompressed kernel module to verify the appended signature.
>
> Since IMA can access both xattr and appended kernel module signature
> with the new LSM hook, it no longer uses the security_kernel_post_read_fi=
le
> LSM hook for kernel module loading.
>
> Before enabling in-kernel module decompression, a kernel module in
> initramfs can still be loaded with ima_policy=3Dsecure_boot. So adjust th=
e
> kernel module rule in secure_boot policy to allow either an IMA
> signature OR an appended signature i.e. to use
> "appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig".
>
> Reported-by: Karel Srot <ksrot@redhat.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
> v1: https://lore.kernel.org/linux-integrity/20250928030358.3873311-1-coxu=
@redhat.com/
>
>  include/linux/lsm_hook_defs.h       |  2 ++
>  include/linux/security.h            |  7 +++++++
>  kernel/module/main.c                | 10 +++++++++-
>  security/integrity/ima/ima_main.c   | 26 ++++++++++++++++++++++++++
>  security/integrity/ima/ima_policy.c |  2 +-
>  security/security.c                 | 17 +++++++++++++++++
>  6 files changed, 62 insertions(+), 2 deletions(-)

We don't really need a new LSM hook for this do we?  Can't we just
define a new file read type, e.g.  READING_MODULE_DECOMPRESS, and do
another call to security_kernel_post_read_file() after the module is
unpacked?  Something like the snippet below ...

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..f127000d2e0a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3693,6 +3693,14 @@ static int init_module_from_file(struct file *f, con=
st ch
ar __user * uargs, int
                       mod_stat_add_long(len, &invalid_decompress_bytes);
                       return err;
               }
+
+               err =3D security_kernel_post_read_file(f,
+                                                    (char *)info.hdr, info=
.len,
+                                                    READING_MODULE_DECOMPR=
ESS);
+               if (err) {
+                       mod_stat_inc(&failed_kreads);
+                       return err;
+               }
       } else {
               info.hdr =3D buf;
               info.len =3D len;

--=20
paul-moore.com
