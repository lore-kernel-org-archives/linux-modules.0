Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2E1898EA;
	Fri, 15 Nov 2024 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661230; cv=none; b=amjEkA9t8Lakilm+PlRltn4Zf3WJVHB0FfWPholimq47uA6hupoSJhIcbUhzQuWPCo95654zdCYokkRhSPjEm/m9Q7eQQb1u+OEpfOJvkbdJJRwMrV/wBJoxCI+/xx+U/lh/TUwllTzZBwxavOBN+2nBiKjKOeyX7MDYuBNvq+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661230; c=relaxed/simple;
	bh=0nwQEzD9oM38WKhLrCWGJCjvZHn0WdmUqf5eGFcbjoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lGNs3hxHcEQ9fCBFXz2zGMTIFfmP971P1j1IgOVfkz4QqUTXWDldbisEA9eyvxFD2L2KX39b45TE8gHp0vz0emiuJc340gC0W3NfCFmEX8F3ezyLXmidnFclRXpV9/b5v5G7VeBt6UnVy9hu2czxG7ro5Xd1BDQ75r+py2jWjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=gEIaLEfR; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="gEIaLEfR"
Received: from [192.168.42.96] (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 892052FC0055;
	Fri, 15 Nov 2024 10:00:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731661224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7yJpDy9PapnyIZwSb/TtFCIBUwleiucaBEmlb/DtGE=;
	b=gEIaLEfRt18hqTOn5ApqTSzh7GXWKwDwBzxdDo3saNVD1dXYtI6aKPGt2hOrn+FcSiuQU0
	2Lm296yMH782FJNSb1iaWfSTbjaDLf4/ece7Qx76o4Rf6HFBjzmuO56GRSfauXGD+YolBs
	vPfkq0jCZssAgMxfTbfkCIVryhp9VGk=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <58b85a78-55aa-422c-a21d-254eb16cc8c6@tuxedocomputers.com>
Date: Fri, 15 Nov 2024 10:00:23 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Luis Chamberlain
 <mcgrof@kernel.org>, tux@tuxedocomputers.com,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>,
 Vinzenz Vietzke <vv@tuxedocomputers.com>, Christoffer Sandberg <cs@tuxedo.de>
References: <20241114103133.547032-4-ukleinek@kernel.org>
 <e32e9f5c-3841-41f7-9728-f998f123cc8a@tuxedocomputers.com>
 <2024111557-unlighted-giggle-0d86@gregkh>
 <6c1952bc-f58d-4c55-887e-6aa247daec5c@tuxedocomputers.com>
 <h5q36ajuzgwf5yrjmqv46x62evifcgoi5imxhcvsv7oxauvxak@sj54oisawqnf>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <h5q36ajuzgwf5yrjmqv46x62evifcgoi5imxhcvsv7oxauvxak@sj54oisawqnf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Uwe,

Am 15.11.24 um 08:29 schrieb Uwe Kleine-König:
> Hello Werner,
>
> On Fri, Nov 15, 2024 at 07:09:49AM +0100, Werner Sembach wrote:
>> Am 15.11.24 um 05:43 schrieb Greg KH:
>>> On Thu, Nov 14, 2024 at 11:49:04AM +0100, Werner Sembach wrote:
>>>> Am 14.11.24 um 11:31 schrieb Uwe Kleine-König:
>>>>> the kernel modules provided by Tuxedo on
>>>>> https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers
>>>>> are licensed under GPLv3 or later. This is incompatible with the
>>>>> kernel's license and so makes it impossible for distributions and other
>>>>> third parties to support these at least in pre-compiled form and so
>>>>> limits user experience and the possibilities to work on mainlining these
>>>>> drivers.
>>>>>
>>>>> This incompatibility is created on purpose to control the upstream
>>>>> process. Seehttps://fosstodon.org/@kernellogger/113423314337991594 for
>>>>> a nice summary of the situation and some further links about the issue.
>>>>>
>>>>> Note that the pull request that fixed the MODULE_LICENSE invocations to
>>>>> stop claiming GPL(v2) compatibility was accepted and then immediately
>>>>> reverted "for the time being until the legal stuff is sorted out"
>>>>> (https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427).
>>>> As already being implied by that commit message, this is sadly not an issue
>>>> that can be sorted out over night.
>>>>
>>>> We ended up in this situation as MODULE_LICENSE("GPL") on its own does not
>>>> hint at GPL v2, if one is not aware of the license definition table in the
>>>> documentation.
>>> That's why it is documented, to explain this very thing.  Please don't
>>> suggest that documenting this is somehow not providing a hint.  That's
>>> just not going to fly with any lawyer who reads any of this, sorry.
>> You are right, that's why when I became aware of the situation this Monday https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/9db67459510f18084694c597ff1ea57ef1842f4e
> We should differentiate two situations here: The one is from Monday
> when you realised that a non-GPL2 compatible kernel module is unable to
> use many functions. The other (and IMHO more relevant) is when GPLv3 was
> chosen knowing it's incompatible with the kernel's license. I would
> argue that you were aware of that since at least March this year
> (https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/issues/137#note_1807179414).

Yes I was aware of this for in-tree modules, I was not aware of this for out of 
tree modules: 
https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/issues/137#note_2066858305

Sadly I did not get corrected on my mistake back then, otherwise I would have 
started then to get things moving and not only last Monday.

>
> And in my opinion
> https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427
> was a wrong reaction. I received this as a statement that your company's
> goals are important enough to not adhere to the kernel's license and the
> open source spirit. This was what triggered me to create the patch under
> discussion.

The revert was done not to block the release of the fan control for the Sirius, 
and as already mentioned in the commit: It is a temporary action.

I hoped to gain more time. TBH I feel a little bit of regret doing this 
experimentation in public now, as I would have had probably more time if i 
didn't (no offense).

>
>> I got the gears to resolve this into moving (me playing devils advocate here
>> is directly related to this https://lore.kernel.org/all/17276996-dcca-4ab5-a64f-0e76514c5dc7@tuxedocomputers.com/)
>> and then returned on working on the code rewrite for upstream ( https://lore.kernel.org/all/8847423c-22ec-4775-9119-de3e0ddb5204@tuxedocomputers.com/
>> is directly related to that), because I'm a developer not a lawyer.
> I agree that it's unlucky that MODULE_LICENSE("GPL") doesn't apply for
> GPLv3. Not sure if it's sensible to deprecate "GPL" and mandate "GPL v2"
> though.
>
>> Then I get called a liar
> I guess you mean me here saying "That statement isn't consistent with
> you saying to pick GPLv3 as an explicitly incompatible license to
> control the mainlining process. So you knew that it's legally at least
> questionable to combine these licenses."? If so: I understand that this
> is discomfortable suggestion. However with my current understanding it's
> true. If this is a problem with my understanding, please point out where
> I'm wrong.
It's about that second sentence "So you knew that it's legally [...]" which I 
explicitly stated that I was not e.g. 
https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/issues/137#note_2066858305 
from back in august.
>
>> and hit with the nuclear option not even full 3 days later,
> For now we're in the discussion period for this "option". I would expect
> that this patch doesn't go in before 6.12. So 6.13-rc1 should be the
> earliest broken ("enforcing") kernel which probably starts to affect
> your users starting with 6.13 final. The actual decision if and when to
> apply this patch isn't mine though. But you should have at least a few
> weeks to work on resolving the licensing.

Knowing the issue tracker too well, I know that day one of 6.13-rc1 release a 
discussion will might break loose that binds resources not invested in other stuff.

Also can you guarantee that it's not landing in 6.12(.0)?

That's why I asked for a clear timeframe to work with but I don't know if I can 
get one.

>
>> while I'm working on resolving the issue
> This is good. You have my support to revert the patch under discussion
> as soon as this is resolved.
>
>> and in parallel working on improving the code for it to be actually
>> accepted by upstream.
>>
>> If you want prove of my blissful ignorance from just last week please take a
>> look at my comment here: https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/merge_requests/21#note_2201702758
> I indeed wondered about your reaction.
>
>> Now trying to be constructive: Can you give me a timeframe to resolve the
>> license issue before this is merged?
> I would wish that in people's mind open source licensing would be taken
> as serious as for example fiscal laws. If my company was caught as tax
> evader the officials would rather shut down the company's operation than
> to allow another month with unclean bookkeeping.
>
> So if you ask for my opinion, the right thing to do would be to stop
> distributing tuxedo-drivers until this is resolved. Then I'd guess it's
> your company's officials who would tell you about a time frame. But I'm
> aware that I'm on the strong side of the spectrum of possibilities here.

This would break linux installations on many devices and not only fall back on 
TUXEDO I honestly fear.

I was not around when the decision to license tuxedo-drivers (back then called 
tuxedo-cc-wmi) under GPL v3 was made, but I trust the people here that is was 
not done knowingly violating the GPL v2. And you did agree above that 
MODULE_LICENSE("GPL") is somewhat unluckily named.

I guess what I try to convince you and others is that we _are_ taking Open 
Source licenses seriously, but still there are mistakes to be made, especially 
with complex projects like the Linux kernel, e.g. I'm not aware of any other 
project that uses a similar construct to EXPORT_SYMBOL_GPL()/MODULE_LICENSE().

Best regards,

Werner Sembach

>
> Best regards
> Uwe
