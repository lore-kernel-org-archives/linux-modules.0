Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C10D23D7E4;
	Fri, 19 Sep 2025 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758246329; cv=none; b=Yv+r04Oe82oYpG9LJyl9tF1l1iVb+p9GEroTWGw2pzovb33Ou5Nl2IxQo8sj9liCZmb69Tj6UeVd+PIYS4AOTA/pRGHQVSima2IrUxf4rjkWfin7M+lS1ZU5H7+QKJDAbLrkUaYuOjDcKvWB90n8Pa7SJSLA3y4ma1d69yQT4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758246329; c=relaxed/simple;
	bh=9ey6y5/eU3bHqNRLFfXlvaxufW/ymu11IMZPkUYnw+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hltTeQ3kpPwvQcfHFsFMCo7hXmcVUeGFeEPJC+k77RlFL8F+hz+bAmXGs+Ee8VbRvjBHEXrKNOTVKRiHfbTOxMT1J9fMPgHI0+FuuwataDca2IkTT6Hjp6sxt5zgwKHz8jUxxN5hJEv5jSpqe9st2b7hEoeLZ30JRlRIxVdMTvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=USri8h0i; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="USri8h0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1758246319;
	bh=n9pYb6zB3EaUnsut4GBLuBZC5yTnkFwn2FZAmiJprOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=USri8h0iCFwEys9p/aYu0zG8/t8ESHl8XNNY9fzRphY0f4d4xMIwG+3KezIF3PWTK
	 Nxv6/K1PuVoy+C70D/t+dbP1vSF1Pz0RQXMTpC2kvnyj99p6h9YlOqMR5Ifs8xhqTx
	 Dl9vSsQPpHND3Jw8ZlM80eyt6IH9pDvK6UZWjLUA=
X-QQ-mid: esmtpsz17t1758246220t42cc5ebc
X-QQ-Originating-IP: YhHAujqlhBgE18/6JKvMSEV8ibqLhnX/CL/i20ZX0Lg=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Sep 2025 09:43:38 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 41658235515920624
EX-QQ-RecipientCnt: 20
Message-ID: <E5D6C740C99059BF+af37f938-2e5d-4d41-adbc-a0c000d432fd@uniontech.com>
Date: Fri, 19 Sep 2025 09:43:37 +0800
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] ALSA: doc: add docs about improved quirk_flags in
 snd-usb-audio
To: Randy Dunlap <rdunlap@infradead.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>
Cc: linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>,
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>,
 Feng Yuan <fengyuan@uniontech.com>, qaqland <anguoli@uniontech.com>,
 kernel@uniontech.com, linux-modules@vger.kernel.org
References: <20250918-sound-v4-0-82cf8123d61c@uniontech.com>
 <20250918-sound-v4-5-82cf8123d61c@uniontech.com>
 <dcbd2c62-5db8-4eb5-aa3a-532b33baaa61@infradead.org>
Content-Language: en-US
From: Cryolitia PukNgae <cryolitia@uniontech.com>
In-Reply-To: <dcbd2c62-5db8-4eb5-aa3a-532b33baaa61@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OQ+eaxRKS8WJsBoYbMlRdEjlU2vB10t84jxZQKpEoESlnbxLsfac5rdu
	hEsDW9nXJaW0XeAtPkwVLwiplEX3zMRRP5cmfooY6eatQepek7Bpo3lu3hz9NPP+1DRT4/G
	ynaEiQZ1tGDha783BGvx74gy4FWYJO4gfOMOC5ZDEnffyFor5zmAgNqZ6SYt0Gg3KhpmO5b
	QxMzTM89m7OOflq8v21Jdxus17LcLy+4FHBsg9OLQEgVOYGyaPCEwOG7G0U73XS8vYgVwQy
	Wl/8n4GELhY8zJNtaxyQL+ZMQoICF9MhKbfOg6d8CGW2cQSHROvJvXczph9Zbomm9T0SUcT
	ct6wVU99yxOs2eEvycrGb4jZKV6DhHLgZ3ev0b9nJGApp9q4AJ6boXI3lSdV5yWFO4dlaVr
	3QrnAtJQPFMUDzPVO2L5rIxmWgS/+3fhC5fHqkWlv3tICQYB74Jm/2NTIaY+P2KKFKIcf8A
	v57/A4VHhC3BWdl5q1ABzYyLl0qU7W5xV9RqRMyis3zVr/ft1ResaqzVTiziP0QOGKCEdFl
	w7JVXYzEYpdy9dI95Ze4ETqNrT3t97/WjX734kQna+bXQH+MXgNgKI6jq4lJVrv+DNeLpLJ
	5Fqo4c4HqI5RxsL7PTDuVc0BXa9UBua0QckWjlPJllyx9exVwTlHKnyZRy3qWFdb65kPDM3
	eoY5hXGIlOEsgnx7wGRGr7Y1IGglft2FYlgeVCYCqTQKlM8PREhooKABKZ+dabg+1EgvOOT
	XQ84eFnyAkWA1sWzcQz6qV57JD+OExrTeEsZ++WdAV0SRClKJtRNGqXSajfMcuW/jEBkcFS
	INIDRbiXh+OoySkbbrYkqodPw6/0E1vaMey9rSX6LlFIDILewwwgFh6ShkOCL3A+QiKGu7z
	1TJkIPB3TepdyjOdsd6sIBXgPHksQOolsjGnQ/4JBm6lzdot704q0xzxi1vR+mEd7j0/ZnK
	ouyFLL2hv/CgtONRJ8oFl9EzJOTNNPsr0BTDpM565DbSM0X2Y9Fe5DJ1fF1OHoBtCR1GwRn
	hDbCwSMfB1AYAt8EvNCruBeQWGw0WwddBGICWROolSy1ubDGAIw8/FLGGVL1sG3YcOX71g4
	t2gPWC5nRpraQgrz3+T9lMYYZkpVToEsKKtfQxER+ifL1GJ5oQzM01HHQaVeRwoj/73r0yI
	PNvcVPxlUINg9OoT8iJvVQmArw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Thanks for your review. I'll waiting some reviews on other patches and resend
a new version about it.

On 19/09/2025 04.21, Randy Dunlap wrote:
> Hi--
> 
> On 9/18/25 2:24 AM, Cryolitia PukNgae via B4 Relay wrote:
>> From: Cryolitia PukNgae <cryolitia@uniontech.com>
>>
>> Just briefly described about the option.
>>
>> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
>> ---
>>  Documentation/sound/alsa-configuration.rst | 108 ++++++++++++++++++++---------
>>  1 file changed, 75 insertions(+), 33 deletions(-)
>>
>> diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
>> index a2fb8ed251dd0294e7a62209ca15d5c32c6adfae..efffe3d534beeddcb6a47ac27a24defb6879f534 100644
>> --- a/Documentation/sound/alsa-configuration.rst
>> +++ b/Documentation/sound/alsa-configuration.rst
>> @@ -2297,39 +2297,81 @@ skip_validation
>>      of the unit descriptor instead of a driver probe error, so that we
>>      can check its details.
>>  quirk_flags
>> -    Contains the bit flags for various device specific workarounds.
>> -    Applied to the corresponding card index.
>> -
>> -        * bit 0: Skip reading sample rate for devices
>> -        * bit 1: Create Media Controller API entries
>> -        * bit 2: Allow alignment on audio sub-slot at transfer
>> -        * bit 3: Add length specifier to transfers
>> -        * bit 4: Start playback stream at first in implement feedback mode
>> -        * bit 5: Skip clock selector setup
>> -        * bit 6: Ignore errors from clock source search
>> -        * bit 7: Indicates ITF-USB DSD based DACs
>> -        * bit 8: Add a delay of 20ms at each control message handling
>> -        * bit 9: Add a delay of 1-2ms at each control message handling
>> -        * bit 10: Add a delay of 5-6ms at each control message handling
>> -        * bit 11: Add a delay of 50ms at each interface setup
>> -        * bit 12: Perform sample rate validations at probe
>> -        * bit 13: Disable runtime PM autosuspend
>> -        * bit 14: Ignore errors for mixer access
>> -        * bit 15: Support generic DSD raw U32_BE format
>> -        * bit 16: Set up the interface at first like UAC1
>> -        * bit 17: Apply the generic implicit feedback sync mode
>> -        * bit 18: Don't apply implicit feedback sync mode
>> -        * bit 19: Don't closed interface during setting sample rate
>> -        * bit 20: Force an interface reset whenever stopping & restarting
>> -          a stream
>> -        * bit 21: Do not set PCM rate (frequency) when only one rate is
>> -          available for the given endpoint.
>> -        * bit 22: Set the fixed resolution 16 for Mic Capture Volume
>> -        * bit 23: Set the fixed resolution 384 for Mic Capture Volume
>> -        * bit 24: Set minimum volume control value as mute for devices
>> -          where the lowest playback value represents muted state instead
>> -          of minimum audible volume
>> -        * bit 25: Be similar to bit 24 but for capture streams
>> +    The option provides a refined and flexible control for applying quirk
>> +    flags.  It allows to specify the quirk flags for each device, and could
> 
>                                                                      and may
> or: and can
> 
>> +    be modified dynamically via sysfs.
>> +    The old usage accepts an array of integers, each of which apply quirk
> 
>                                                                  applies
> 
>> +    flags on the device in the order of probing.
>> +    e.g. ``quirk_flags=0x01,0x02`` applies get_sample_rate to the first
> 
>        E.g.,
> 
>> +    device, and share_media_device to the second device.
>> +    The new usage accepts a string in the format of
>> +    ``VID1:PID1:FLAGS1;VID2:PID2:FLAGS2;...``, where ``VIDx`` and ``PIDx``
>> +    specify the device, and ``FLAGSx`` specify the flags to be applied.
>> +    ``VIDx`` and ``PIDx`` are 4-digit hexadecimal numbers, and could be
> 
>                                                            s/could/may/
> 
>> +    specified as ``*`` to match any value.  ``FLAGSx`` could be a set of
> 
>                                                       s/could/may/
> 
>> +    flags given by name, separated by ``|``, or a hexadecimal number
>> +    representing the bit flags.  The available flag names are listed above.
> 
>                                                               s/above/below/ ?
> 
>> +    An exclamation mark could be prefixed to a flag name to negate the flag.
>                        s/could/may/
> 
>> +    For example, ``1234:abcd:mixer_playback_min_mute|!ignore_ctl_error;*:*:0x01;``
> 
> What happens if the trailing (ending) ';' is omitted?

This is where I found something strange when I was testing it myself. When I use
`echo '*:*:mixer_playback_min_mute` > /sys/module/snd_usb_audio/parameters/quirk_flags`,
the string received by the driver contains a lot of trailing spaces. I am not familiar
with the kernel and don't know how to handle this situation. Simply adding a semicolon
to the input will make the trailing spaces after the semicolon be ignored.

> 
>> +    applies the ``mixer_playback_min_mute`` flag and clears the
>> +    ``ignore_ctl_error`` flag for the device 1234:abcd, and applies the
>> +    ``skip_sample_rate`` flag for all devices.
>> +
>> +        * bit 0: ``get_sample_rate``
>> +          Skip reading sample rate for devices
> 
> get vs Skip is a little confusing.

This part is copied from Takashi Iwai[1]. It does a little confusing.

>> +        * bit 1: ``share_media_device``
>> +          Create Media Controller API entries
>> +        * bit 2: ``align_transfer``
>> +          Allow alignment on audio sub-slot at transfer
>> +        * bit 3: ``tx_length``
>> +          Add length specifier to transfers
>> +        * bit 4: ``playback_first``
>> +          Start playback stream at first in implement feedback mode
>> +        * bit 5: ``skip_clock_selector``
>> +          Skip clock selector setup
>> +        * bit 6: ``ignore_clock_source``
>> +          Ignore errors from clock source search
>> +        * bit 7: ``itf_usb_dsd_dac``
>> +          Indicates ITF-USB DSD based DACs
> 
>                                DSD-based
> 
>> +        * bit 8: ``ctl_msg_delay``
>> +          Add a delay of 20ms at each control message handling
>> +        * bit 9: ``ctl_msg_delay_1m``
>> +          Add a delay of 1-2ms at each control message handling
>> +        * bit 10: ``ctl_msg_delay_5m``
>> +          Add a delay of 5-6ms at each control message handling
>> +        * bit 11: ``iface_delay``
>> +          Add a delay of 50ms at each interface setup
>> +        * bit 12: ``validate_rates``
>> +          Perform sample rate validations at probe
>> +        * bit 13: ``disable_autosuspend``
>> +          Disable runtime PM autosuspend
>> +        * bit 14: ``ignore_ctl_error``
>> +          Ignore errors for mixer access
>> +        * bit 15: ``dsd_raw``
>> +          Support generic DSD raw U32_BE format
>> +        * bit 16: ``set_iface_first``
>> +          Set up the interface at first like UAC1
>> +        * bit 17: ``generic_implicit_fb``
>> +          Apply the generic implicit feedback sync mode
>> +        * bit 18: ``skip_implicit_fb``
>> +          Don't apply implicit feedback sync mode
>> +        * bit 19: ``iface_skip_close``
>> +          Don't closed interface during setting sample rate
> 
>                    close
> 
>> +        * bit 20: ``force_iface_reset``
>> +          Force an interface reset whenever stopping & restarting a stream
>> +        * bit 21: ``fixed_rate``
>> +          Do not set PCM rate (frequency) when only one rate is available
>> +          for the given endpoint
>> +        * bit 22: ``mic_res_16``
>> +          Set the fixed resolution 16 for Mic Capture Volume
>> +        * bit 23: ``mic_res_384``
>> +          Set the fixed resolution 384 for Mic Capture Volume
>> +        * bit 24: ``mixer_playback_min_mute``
>> +          Set minimum volume control value as mute for devices where the
>> +          lowest playback value represents muted state instead of minimum
>> +          audible volume
>> +        * bit 25: ``mixer_capture_min_mute``
>> +          Be similar to bit 24 but for capture streams
> 
>              Similar to
> 
>>  
>>  This module supports multiple devices, autoprobe and hotplugging.
>>  
>> Are all of these quirks used on various devices or are some of these
> just implemented just in case they are needed in the future?thanks.

I believe in that all of them are used in quirk_flags_table in sound/usb/quirks.c

1. https://lore.kernel.org/all/20210729073855.19043-2-tiwai@suse.de/

Best regards,
Cryolitia

