Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99FB1F8193;
	Thu, 14 Nov 2024 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582862; cv=none; b=Duv7d/nhqx1b6Vj3kLB4JZ17NZ7RNzt6o+zQiylrD+K4KaBDhT1ijkC6gGFsWkyT0cqGAqIGg77qlXb9YjSlBh4n/S9S/U/juFfbqXhzQjHJSz8WyxI3bJBpKppArT+9zcJ2cHwm8XvOAtVQuwUFmtRu8VQIIN/e8JEJJnQ+xQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582862; c=relaxed/simple;
	bh=EH9hwU1mzPi6AlkDMNhH5/MmE32MjwtQZgX3Oap6itA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjpCRLv41ZMDM6VU+ljA6yYZ375Wx5z413dHlPRW2GW8dC3esPxVHG3L2RYzIU7s4PmsUwA1Pt1B82FbaxAZlitw513YQfVUUoPLQC8CvK7ALiE/VKTC0PI3KKiPkwHAVKjb8ATylaAvFyRmA64qmAtMH64J13etOoKyM7sQuZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLwB3klD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLwB3klD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF26C4CECD;
	Thu, 14 Nov 2024 11:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731582861;
	bh=EH9hwU1mzPi6AlkDMNhH5/MmE32MjwtQZgX3Oap6itA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BLwB3klDDzSqqnsvGctGBsR589EfntJEeqFjLUfb0svOLKZa4/stg8J7AFScvm+m5
	 AW1MskGlFFEpGrgtMX5ClKhG0pepBycsuzNRi0gJSDwXOR+V2stTwCUpbiJtLWwvdH
	 tHFupOA+qKMTBS12Cs5HfYsNGcUhYhkrPkanMGJlQPB3bxN/wBtTY8vg6oupq4atmd
	 0hdZ9VKBoP43w8ZLaqDJl6eTRWkbuWgq6l1HqiLyGb4yDcZvFy1b3bnnbYQltQXRCA
	 B/Q0DT3RtVmKWqNz/Gvfgyfbx16AjkYhkzKvtoJgjO3aoI6yREIWK750PghDBeNZRc
	 3UtJLJBAz97vQ==
Message-ID: <e7d97b3d-1880-4c89-bbf2-a742d6ac9e6b@kernel.org>
Date: Thu, 14 Nov 2024 12:14:16 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
To: Werner Sembach <wse@tuxedocomputers.com>,
 Luis Chamberlain <mcgrof@kernel.org>
Cc: tux@tuxedocomputers.com, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
Content-Language: en-US, de-DE
From: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
In-Reply-To: <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 11/14/24 11:49, Werner Sembach wrote:
> Am 14.11.24 um 11:31 schrieb Uwe Kleine-König:
>> the kernel modules provided by Tuxedo on
>> https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers
>> are licensed under GPLv3 or later. This is incompatible with the
>> kernel's license and so makes it impossible for distributions and other
>> third parties to support these at least in pre-compiled form and so
>> limits user experience and the possibilities to work on mainlining these
>> drivers.
>>
>> This incompatibility is created on purpose to control the upstream
>> process. See https://fosstodon.org/@kernellogger/113423314337991594 for
>> a nice summary of the situation and some further links about the issue.
>>
>> Note that the pull request that fixed the MODULE_LICENSE invocations to
>> stop claiming GPL(v2) compatibility was accepted and then immediately
>> reverted "for the time being until the legal stuff is sorted out"
>> (https://gitlab.com/tuxedocomputers/development/packages/tuxedo- 
>> drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427).
> 
> As already being implied by that commit message, this is sadly not an 
> issue that can be sorted out over night.
> 
> We ended up in this situation as MODULE_LICENSE("GPL") on its own does 
> not hint at GPL v2, if one is not aware of the license definition table 
> in the documentation.

That statement isn't consistent with you saying to pick GPLv3 as an 
explicitly incompatible license to control the mainlining process. So 
you knew that it's legally at least questionable to combine these licenses.

The only thing I could accept here is that you were surprised that the 
incompatibility has some technical enforcement resulting in your modules 
to become nonfunctional. But that's like a thieve in a supermarket who 
asks for forgiveness because while he was aware that steeling is not 
allowed, wasn't aware there is video surveillance that might actually 
catch him.

So I'd claim MODULE_LICENSE("GPL") not being explicit to not apply for 
GPLv3 code is not a valid excuse. (Which doesn't mean the kernel 
couldn't improve here.)

Best regards
Uwe
