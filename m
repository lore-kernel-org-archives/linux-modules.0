Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0095625DCF6
	for <linux-modules@vger.kernel.org>; Thu,  5 Jun 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131011; cv=none; b=YN1ycPgW7alI72BgXTyS2zfwVFm2L/gvrZx3pDngwWlkZRJLdvDnnC9RpcLvKRAkV3FhMLtMHaG2NzhFR4Y6snUEvSQjD9bnPliSplFYpyOCENAVGutCsKMeJ9whNoslAvfeqHQyl/fEu8prnrIk0v2tdf/9pECo4JAHsGac93E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131011; c=relaxed/simple;
	bh=Ibr9kab54z+bb8Bbxb6yjOzT0aoFx9OQrLydi6uSjbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J6BWO7otvO046ynPJsPwBR/7CDVjdq4PZpnJ5hj8RW8zhIOOYAeybPWIVMO0qlsAwINeyDQ1pEsvMu3rYGwYllQx38NiQKOPvwfZURXcX3pnTHE+ylTZrvqgksdMyCXGNNPoq7NI1DyislUiOMRQFUdmvToNwSkEKsGGN7oMBGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNA15Cd8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNA15Cd8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749131008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyJG+3VB/l9E5cKEG16NYCx4C/OXUyDFX/570MgrW70=;
	b=iNA15Cd8S78GMHiqmTtJRRE+4RsyJuou/0TODwYIt6Pw37ZKG03qiTII9LwMP4Z1WjBF0J
	zXgh/lJNFm8wgi75BbyArz5n4fw5NHMaK8UIwzgFeg/5zmrEsvF+/5gm9jOW+d63mLHziO
	ras70z0OPRE/WllhI4vnANyj5IH1mIo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-XZxkpyrZM3q0qwMf9v2lhQ-1; Thu, 05 Jun 2025 09:43:26 -0400
X-MC-Unique: XZxkpyrZM3q0qwMf9v2lhQ-1
X-Mimecast-MFC-AGG-ID: XZxkpyrZM3q0qwMf9v2lhQ_1749131005
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50816cc58so386752f8f.3
        for <linux-modules@vger.kernel.org>; Thu, 05 Jun 2025 06:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749131005; x=1749735805;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WyJG+3VB/l9E5cKEG16NYCx4C/OXUyDFX/570MgrW70=;
        b=iVkLaI9eBDZJgFLiWB/ycCqEaeNXsIIR4nKAM/MLpOakPRiOnpFV71MX3n2pttVGAz
         Oh5EIvFx7ooraLGb961JUth4fYzq2L/r9vNnofZavhTfwZfTxgtXcE4s1f2PQMBQtjFb
         /1/bYRv88+4Nbbl9Erk+zF3Ed4m4dNUtt7NXkC/x3xRqDnrMgaXZzgaoUCHmxpSmMyHC
         U+J6bW27CqwWZLPfmjETjMUYn+Vg4HzDlPWc1queD0XuJoDSuI3IQZNutTs3iEF9Y8t2
         i9GM8jd/VjIU7UIKIW8hUyhMI/uJNxasRbfGHGF3p1mJV5mEUU9U9aZVnhrJ8xV6ZhL8
         M6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUUuAnv7Fe1Hbl9NRgLh1oK1owNRnXub/o8u67qHNSVM9JKuvE+ApfmkXkKuUalKt16OmrfGdZWpufVdpAI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0laBuDIbi15bx/DQR6pmTw2W097Ly+K9svAmMdzknPFdcArfP
	IwvlZfHxxSIsXauw/9Y5A4SWJYHaWHtIt+JNIMOsH9oCgIxNoznLB0JG/lue4Iu2EB5p4AU9EEn
	jyU2fFC+HBnBscrgCAgTO1xpn0wvTgS80xJ7BjR+QCkByf4q/CUu1WxgDQmis75K8rxk=
X-Gm-Gg: ASbGncu7gm66QGiF6XWzZTb/vcu98PbAT33E4AiM4B4vR6NfPTCqq9BrQsxX393r2Cm
	gG5XMrZc9V8gUvVzeABcfiTDJrXKV/UT7MWM6T+HtODjoKjhh1R08j85i0h997am5QoFX3CwLkh
	ChKvgn3+vYz0/P85UEWAf3oK/LO/Bq+AaP7Cp0RhpMrTONbFkTlbbW4YrY9IJ5bnRG+6sRQeh0c
	b/0IpZEzEXUgzWgtTFgcBpZM04M6CnlEdJ5gMEJjxUG1oRslBFUkZZm5WYMW/ZXHGdaIX83eljq
	5sysMrA=
X-Received: by 2002:a05:6000:144c:b0:3a4:fc37:70e4 with SMTP id ffacd0b85a97d-3a51d97408amr5757689f8f.58.1749131005256;
        Thu, 05 Jun 2025 06:43:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH06+3a1Kbk78BFgL3ZwbDTDTsWsomlMTVTUM+GFt6c6uDgEbkD9kGtXYidxIou37MFPIzdSQ==
X-Received: by 2002:a05:6000:144c:b0:3a4:fc37:70e4 with SMTP id ffacd0b85a97d-3a51d97408amr5757647f8f.58.1749131004775;
        Thu, 05 Jun 2025 06:43:24 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b8f0sm24267394f8f.6.2025.06.05.06.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 06:43:24 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Eric Snowberg
 <eric.snowberg@oracle.com>
Cc: "linux-security-module@vger.kernel.org"
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
In-Reply-To: <e4e838d03b3619df5523d429e0cd8160a8aef9f8.camel@HansenPartnership.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <0FD18D05-6114-4A25-BD77-C32C1D706CC3@oracle.com>
 <f0b37bc55ed3c02569c74f0fbdb6afa8efd329e2.camel@HansenPartnership.com>
 <87zfemoc76.fsf@redhat.com>
 <e4e838d03b3619df5523d429e0cd8160a8aef9f8.camel@HansenPartnership.com>
Date: Thu, 05 Jun 2025 15:43:23 +0200
Message-ID: <87tt4unw1w.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Thu, 2025-06-05 at 09:54 +0200, Vitaly Kuznetsov wrote:
>> One additional consideration is the fact that we already trust 'db'
>> for dm-verity (since 6fce1f40e951) and kexec (since 278311e417be) and
>> especially the later gives someone who is able to control 'db' access
>> to CPL0; a 'db'-signed module (IMO) wouldn't change much.
>
> Well, the kexec case is because kexec has to verify the new kernel as
> shim would and shim would use the UEFI keys.  The dm-verity one was
> added for a cloud use case by pressuring the maintainers in spite of
> the objection to using the platform keyring (it went to dm-devel only
> so not many integrity people saw it):
>
> https://lore.kernel.org/all/20240617220037.594792-1-luca.boccassi@gmail.com/
>
> The point here is I do think the cloud use case is legitimate, but it
> can't be supported simply by ignoring the bare metal security domain
> separation concerns of the integrity community.  The argument that
> distros have done it so it must be safe isn't really a winning one
> (especially as there's no clear explanation of why they did it).  So
> either you need a better argument or we need a way to support both sets
> of communities ... which is why I was wondering about a runtime
> differentiator.

So far, I got two 'runtime' ideas:
- Observe MokListTrustedRT and distrust .platform when it is
non-empty. This can, of course, be combine with a Kconfig for those, who
do not want it at all.

and/or
- Sysctl toggle. Keep things as they are by default but make .platform
trusted (either for modules or for everything) when switched 'on'. This
can (optionally) by combined with a previous idea and have e.g. an
'auto' state for the toggle which follows MokListTrustedRT.

-- 
Vitaly

