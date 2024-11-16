Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22519046E;
	Sat, 16 Nov 2024 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731782495; cv=none; b=axogZAmDvbfmHk3qyTjZLNXyHyCLcVl1+tnrPJjBXb5okV+2BA+8x0wRrEAb2Wl6eLaidv6p9EKWbNncxVyeED0TIa3POLOudlXv2lhxBE9Lyy9am/rn3nILvR+uFBddMunmFUQUDsc+qDg+FUJWnPSHvWLGHsPamT/+Kfdk2Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731782495; c=relaxed/simple;
	bh=TUu/axCnwXUSPjl7DmdASpjS+JzTdRRaW1X3JGCd1HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nz8pFabJKedlC8Q8t3fIFwTr5KcI1IFH9Jh/1UTzHGqwOorRaYqlMC7YAT472uZbqsHKgWZ7hTCx2f33fpiAZKIg7YMMPV97GG0gWP0kQ2uUJKKM1gP9W3BnT/+cV3nrG3xIBrXh1z6qcjtnyCj2Ji3+Ux8qEYoZTZEHDNzHlPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=uIiICG1h; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="uIiICG1h"
Received: from [192.168.42.27] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id C853F2FC0057;
	Sat, 16 Nov 2024 19:41:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731782483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBqRSlWZvIoHn8A7/4oK+jcLVTVxG6tAyXjnQGfUghI=;
	b=uIiICG1h2poU+bwTMHITZuDQcptlbgqEOAAnOCIGILOZD9Hv6bx5l3Wqf79Ur0CmY59/rx
	glWr+qRCSZdkWmfpEGs3/JDEAxjRfenJHwV/cyWoPz+RyfvR4uXEcBvRfQtrG3eKtJ90Eh
	9v+4fIO4zBiQEpyBTg9IIdb1YSx1gdU=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <2a82f2e1-070a-4269-8b8e-26c5f188c85f@tuxedocomputers.com>
Date: Sat, 16 Nov 2024 19:41:22 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, tux@tuxedocomputers.com,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
 <e7d97b3d-1880-4c89-bbf2-a742d6ac9e6b@kernel.org>
 <ozjiojcjmdjppmtardffvrqkuksnexyhfttzbyandihzhg6n3t@ssscyybngobw>
Content-Language: de-DE
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <ozjiojcjmdjppmtardffvrqkuksnexyhfttzbyandihzhg6n3t@ssscyybngobw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Uwe,

Am 16.11.24 um 18:49 schrieb Uwe Kleine-König:
> Hello,
>
> On Thu, Nov 14, 2024 at 12:14:16PM +0100, Uwe Kleine-König wrote:
>> On 11/14/24 11:49, Werner Sembach wrote:
>>> Am 14.11.24 um 11:31 schrieb Uwe Kleine-König:
>>>> the kernel modules provided by Tuxedo on
>>>> https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers
>>>> are licensed under GPLv3 or later. This is incompatible with the
>>>> kernel's license and so makes it impossible for distributions and other
>>>> third parties to support these at least in pre-compiled form and so
>>>> limits user experience and the possibilities to work on mainlining these
>>>> drivers.
>>>>
>>>> This incompatibility is created on purpose to control the upstream
>>>> process. See https://fosstodon.org/@kernellogger/113423314337991594 for
>>>> a nice summary of the situation and some further links about the issue.
>>>>
>>>> Note that the pull request that fixed the MODULE_LICENSE invocations to
>>>> stop claiming GPL(v2) compatibility was accepted and then immediately
>>>> reverted "for the time being until the legal stuff is sorted out"
>>>> (https://gitlab.com/tuxedocomputers/development/packages/tuxedo-
>>>> drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427).
>>> As already being implied by that commit message, this is sadly not an
>>> issue that can be sorted out over night.
>>>
>>> We ended up in this situation as MODULE_LICENSE("GPL") on its own does
>>> not hint at GPL v2, if one is not aware of the license definition table
>>> in the documentation.
>> That statement isn't consistent with you saying to pick GPLv3 as an
>> explicitly incompatible license to control the mainlining process. So you
>> knew that it's legally at least questionable to combine these licenses.
> When I wrote this mail I missed the possibility that while Werner knew
> GPLv3 isn't ok for in-kernel code might still have considered GPLv3 ok
> for external modules anyhow.
>
> So I take back what I said and excuse me for my words. They were not
> intended as harsh as Werner obviously took them, but still I regret
> having written my reply with this suggestion.
>
> I'm sorry,
> Uwe
Thank you very much for these words.

I hope that in my replies I wasn't too harsh from my side and if so, I 
too want to apologize for it.

No more bad feelings going forward.

Best regards,

Werner Sembach

