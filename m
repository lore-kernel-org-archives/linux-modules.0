Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44B288C25
	for <linux-modules@vger.kernel.org>; Fri, 10 Oct 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102709; cv=none; b=cX2zLfLfmZd19uNrjvJubHlSV12qx2s3FX4VkStAzI88EOuImGgI09QP67NVdpCE+7Fr4x1v0HIVLjW9oA0iMcEWs25Kj5l1h4n9FgERXJAag8UW2kDO3l/nw4M8lx4AJyRssV75F7iD5eC9APN4d88kH7AH5ZnQUWQ1/dcFBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102709; c=relaxed/simple;
	bh=O8RrubSJRJZ2eKPZ0ANfpKCQVkOdvA+RtzJWOt2fdes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6/gTWXufDE7pw+H39kjxDQ6nIA/cdHII4uW7SImGJsCLupctJ9MMCR+LatEmnabX9JOykAmDX03VpeCzx0HWk/aAiFSF0tF3z/x+oD2dZnb4jGwxzZq0IAZrHt/dV8B+yGYJ+VsLp5tYZWYSPa49rHg1lmoSziO01yVR57yv3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EXbhgxEt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXbhgxEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760102707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzWKSf9mpTG2YCjUAY9uF/GRv8q15gJjhT+Ik15Q3YU=;
	b=EXbhgxEtoMx1wFfemrRqjNI30R77VW1w54renI372rsE9JrGSqulDcM2UVzi4XzYG8Jt95
	Ct6F7UaMkeuIMMzIZP8+E85rDzBIAqkMIJczMaWsPZRbDCMRlW2M3UDgv6yYQS5fr0eYW+
	f7rMnWLQCEzSPusskDEeNNHf6MLOBTo=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-G5HwpwgZPDazxVvfhURrgA-1; Fri, 10 Oct 2025 09:25:06 -0400
X-MC-Unique: G5HwpwgZPDazxVvfhURrgA-1
X-Mimecast-MFC-AGG-ID: G5HwpwgZPDazxVvfhURrgA_1760102705
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-54aa22d5862so1190681e0c.1
        for <linux-modules@vger.kernel.org>; Fri, 10 Oct 2025 06:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760102705; x=1760707505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzWKSf9mpTG2YCjUAY9uF/GRv8q15gJjhT+Ik15Q3YU=;
        b=El84aCQtOGQnLHvm33XLw/DNIA88kQlWmiphee4ibXfz9hj9NEUHihiEHyCzmmCT8T
         dR13BotpKVDiOP3sDibIx2B5cBx9rSfpWh0b/4Lim7q602m8k2lbXeOYOb2nnplCh456
         9zJpmARY1iSaerPtju/eDeGlryT7WHyn4U5z+i6DKLgtSQddMmnmLyteUcQ5OMABPbtQ
         N39ZlGqx4sscW+7nsJMT4cJe6kd+km7vUhSdcvv82aFvgW9tRPsh8QXYQWvAZalQ+0+U
         XlEJ45mxlxs0C7coThxhSp++7aVphs+TyI+LOOkRSxOGNi6WzutEEYB+AnVpQONjG8it
         Sazw==
X-Forwarded-Encrypted: i=1; AJvYcCVFtqkKAJb5ocSOnv7RHIbtoAAtC+vuOVNCZYoqenwsK0dsBtWrR+3vEIh/+/zhmgmaAuJSg2uQ6LhYANt0@vger.kernel.org
X-Gm-Message-State: AOJu0YyYdlju8ksCStCBf3oWwutU2pjPqvw/+RiLxhjKZNUEEnZ4OKZ6
	tfF6FckwAJSwIUYaXHzEp7R8CyfhihNJ/hstiImDYiPx64VwO9G0AC3Qu+ygEGxGglwg+sQ9yWV
	bStfvQtSRLTDqUEuxzIZLnIrs8bU9i7mYNopX1hPokxF7/vc2iS/ED6n4H2l2UHk7utGqYDSXYL
	79jIoubDOxKRhBtVbxdTs7OHV/ZrrM52Iw58vV1OpoSA==
X-Gm-Gg: ASbGnct0Z2B9SicSPaXKIW/9nTnEzwTfWV2vWjsImMYm3XajcE3TLsN06UPFDBAiJdo
	tgt3PH0jA6wJVRg6tuCI1P53GZ2Fw3T8E+Q7IKKzfvJwaR7nYZSY1gngqJLO6ID/720cIJtaUyu
	Mi7856GtkPx3MgkI8sFqe7uMBEIHru9w==
X-Received: by 2002:a05:6122:2228:b0:544:75d1:15ba with SMTP id 71dfb90a1353d-554b8b972b9mr4105595e0c.8.1760102705434;
        Fri, 10 Oct 2025 06:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9OXHOt0tVCCgO6nU5AlWF0F3DLGcppKFsGZNXFWqEcGcaDnZmPBYeJMuUsD+NzvpJu1hAFAcw2aXzLqvRxr4=
X-Received: by 2002:a05:6122:2228:b0:544:75d1:15ba with SMTP id
 71dfb90a1353d-554b8b972b9mr4105589e0c.8.1760102705084; Fri, 10 Oct 2025
 06:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <28d4da3b0e3fc8474142746bcf469e03752c3208.1758182101.git.legion@kernel.org>
 <20251007011637.2512413-1-cmirabil@redhat.com> <aOToOeNGiaFVM0Ds@example.org>
 <aOgSaNejdcBWKXx8@levanger> <20251010053736.GA447238@ax162>
In-Reply-To: <20251010053736.GA447238@ax162>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Fri, 10 Oct 2025 09:24:54 -0400
X-Gm-Features: AS18NWDAsD56v33pycRJmWk_jcLYYml8a8mta30luj8tpr3fHieg4TWwum9tzMM
Message-ID: <CABe3_aE+A7JtEp-8p6A8yM9ONGU4-c36AUFrtW4tGhpnXbvSuQ@mail.gmail.com>
Subject: Re: [PATCH v8 7/8] modpost: Create modalias for builtin modules
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Alexey Gladkov <legion@kernel.org>, da.gomez@samsung.com, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org, 
	petr.pavlu@suse.com, samitolvanen@google.com, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 1:37=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Thu, Oct 09, 2025 at 09:52:08PM +0200, Nicolas Schier wrote:
> > On Tue, Oct 07, 2025 at 12:15:21PM +0200, Alexey Gladkov wrote:
> > > Hm. Indeed. I haven't found a good solution yet, but you can use the
> > > following patch to unlock compilation. It won't solve the problem, it=
 will
> > > only hide it.
> > >
> > > --- a/scripts/Makefile.vmlinux
> > > +++ b/scripts/Makefile.vmlinux
> > > @@ -84,7 +84,7 @@ endif
> > >  remove-section-y                                   :=3D .modinfo
> > >  remove-section-$(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS) +=3D '.rel*'
> > >
> > > -remove-symbols :=3D -w --strip-symbol=3D'__mod_device_table__*'
> > > +remove-symbols :=3D -w --strip-unneeded-symbol=3D'__mod_device_table=
__*'
> > >
> > >  # To avoid warnings: "empty loadable segment detected at ..." from G=
NU objcopy,
> > >  # it is necessary to remove the PT_LOAD flag from the segment.
> > >
> >
> > Is it problematic to hide that?  Otherwise we'd have to revert the
> > patch, right?
>
> Yeah, I would much prefer to ending up with pointless
> __mod_device_table__ symbols in the final binary than erroring out
> during the build... Does this happen with other architectures? I have
> not seen any reports yet but I have not tested anything yet. Why is
> RISC-V special here?
>
> It seems like the relocation comes from the .LASANLOC4 symbol in
> .data.rel.local?
>
>   $ llvm-objdump -Dr drivers/irqchip/irq-riscv-aplic-main.o
>   ...
>   Disassembly of section .data.rel.local:
>   ...
>   0000000000000130 <.LASANLOC4>:
>   ...
>        1c0: 0000          unimp
>           00000000000001c0:  R_RISCV_64   __mod_device_table__kmod_irq_ri=
scv_aplic_main__acpi__aplic_acpi_match
>   ...
>
> I cannot find much information about this ASANLOC outside of its
> location within the GCC sources, do we even need it? I don't see a way
> to opt out of this section altogether or on a per-variable basis, I
> wonder if there is some way to strip it out...

It seems from reading the gcc source that these are emitted to contain
information about where global declarations came from, presumably to
allow nicer ASAN error messages. (i.e. memory corruption affected this
symbol defined here). I don't think that KASAN uses these, but I am
not sure. I also don't know how they could be removed. I found a hit
using grep.app https://grep.app/search?case=3Dtrue&q=3DASANLOC in the
apache/nuttx repository where they seem to be doing something with
these symbols in a linker script, but I am not familiar enough with
linker scripts, or that project to fully understand what is going on.


>
> I plan to send the initial 6.18 Kbuild fixes pull request on Saturday.
> If we cannot figure out a real solution before then, maybe we can just
> switch to '--strip-unneeded-symbol' with a comment to upgrade that to
> '--strip-symbol' when possible?
>
> Cheers,
> Nathan
>

