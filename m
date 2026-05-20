Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BFF37C930;
	Wed, 20 May 2026 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779312827; cv=none; b=YZdLBzXn2NjFdNvGLLFvC7ZER56iDoXXJUsdymGdwccZd/fZ7d8UafSjBk/Bbcb1SOzEd1MFfg+kxD4v7MtVPpvDpoBoj+pKrnzbYwGRhGAqXQR2Otv2tDFMPQaaMj3XhczPEtWcO3QWnSG87GSAE+zsP77vwkKq7z6AfYHEwzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779312827; c=relaxed/simple;
	bh=EPxcbYJLZc/lrklYCQRDZ8tN6p9116v4gcvMc1bd2Xw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVyvJ+tswn3+EUZgo5R/9IbmZgDiDe44CCH+tGIirZHUuQOrXnWjy9LKtXOXv7PW8Z1kZmm24h9ZLmzaLAq7oQzyi6N24fFL4JmNyvo1eU5WwUsOrYPeakCToAAS4ewiWExm4WAfwBtdX7nvSudUHjdHH+uFXwG50/9vfL6gA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo5vkiXW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo5vkiXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C023B1F000E9;
	Wed, 20 May 2026 21:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779312826;
	bh=E70q9Uwl+Cu+LSi8XOgS2WvHM1D9Yqo2nCLaHoPmdlM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Yo5vkiXW0IoG6UqhTM0xctDCb7mb3syLT/rsmOrxXJeB0dO9Q+IygrkfpIsJQaOFQ
	 SmDVHF3edHfQVBNzm7Uh+5QcxZ1QGQCwDFXX07dujaip7Ohg7ICDkJtigfLoylK3KN
	 2B6KLtwRP2mvx1wislkonvK6kZB7Rm7MZpdC9Kx1p6VqRm/kKji91C0YOnGQN/en+p
	 3budk7pUZnVzJ59iN9dI5HOoofCMKSvQFtd4tLvl5OPrMidbbBDesvvVVdVUC7vf7d
	 K1qTHmPR+GVKx7eFOWC/6NkItM/3AOzkNxTDga09pLpLtabq79YNagndB4qUisSfwQ
	 1xQ/l3OvGtQlg==
Message-ID: <bb4daac1-ee1b-405d-a07a-4b951945d664@kernel.org>
Date: Wed, 20 May 2026 23:33:40 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: decompress: check return value of
 module_extend_max_pages()
To: Afi0 <capyenglishlite@gmail.com>, Sami Tolvanen <samitolvanen@google.com>
Cc: linux-modules@vger.kernel.org, mcgrof@kernel.org,
 dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260518143233.16091-1-capyenglishlite@gmail.com>
 <20260519212328.GA2614626@google.com>
 <CAEABq7f3agKZqrBiu+UwXHY44mTcK360ryg-i0w=wEc_Lv+T0A@mail.gmail.com>
 <CABCJKuej82rrQbQ0eoG+JsY6Fwi0SdVJqduvps7eiPrJ_BgT0A@mail.gmail.com>
 <CAEABq7e5NT0c58gG=fqFK-RmfrgUDA-8jXnmMMQZHMNu4hea5Q@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAEABq7e5NT0c58gG=fqFK-RmfrgUDA-8jXnmMMQZHMNu4hea5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 20/05/2026 à 18:05, Afi0 a écrit :
>    Thanks for the correction. Updated commit message

Please follow kernel rules:
- Mails in plain text, not Mime
- Patches as part of core text, no attachment
- Your real name, not Afi0 <capyenglishlite@gmail.com>
- No top-posting

See:
- 
https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions
- 
https://docs.kernel.org/process/submitting-patches.html#no-mime-no-links-no-compression-no-attachments-just-plain-text


Christophe

> 
> On Wed, May 20, 2026 at 3:13 PM Sami Tolvanen <samitolvanen@google.com 
> <mailto:samitolvanen@google.com>> wrote:
> 
>     On Tue, May 19, 2026 at 9:11 PM Afi0 <capyenglishlite@gmail.com
>     <mailto:capyenglishlite@gmail.com>> wrote:
>      >
>      > Hi,
>      >
>      > You are right, the commit message overstates the impact. The
>     actual result is an immediate kernel oops, not an OOB write into
>     adjacent slab objects. The fix is still correct - checking the
>     return value avoids the oops. Shall I send a v3 with a corrected
>     commit message?
> 
>     Yes, please send v3.
> 
>     Sami
> 

