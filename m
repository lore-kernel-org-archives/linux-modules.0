Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431831CA54;
	Thu, 18 Sep 2025 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226917; cv=none; b=sFOBPVVs2AxAk8zZ2AVq1Fmu1aOtJd7IhXmj9DgIjR3HIU39xpPvUSH1+Q3FjU9SoMiPjVurU3XQdgfUCrxDFd3CNbgv2FOYSBjB0J4D/AZjJOYV2glqiDzzZX2rFOKzILD5yIPG9gpAMxhmxlr4aSzmckKXFRBY5LmadOiQ5XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226917; c=relaxed/simple;
	bh=/3BYsfjMl1cUUSeihEaNsPBMguLnpA3t6+l9GWStjdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMMn4EzcfdtDsRcgkXIo0oyDScGqnQHWsHXnhhkL85/zojQCJV0YqM04AvqOQoYSogdH8nedniNCC/sv76YDg9Nbqbre8IxbeyFyxqyAc5JJinTe+QIISaRoAKhooaslSg5/7NkX7W0DKUsgCvA2puDp4/zz9mS6I0P3KKxBhic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RCBmBHNI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RCBmBHNI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Hw2DbkoUFoUvKQiSp3L3I2iLC/yPwz3ta9B463K5KP0=; b=RCBmBHNIiBj2D1SdDE+KJ4nrZ3
	dxPD54NzPDj0iAP99NMns6nOM65zxnSb1r5/AA4D8Buqbm96ZK7YvEO/sLVHF/4TpzgY7nmpxPLo6
	ijTHkqLI4AN6/Ec5W2UHXM6+Q0jR4JhXXKo/lP0lRR9nqaUYwex3VJVcmrdAIZKOwBbEC5BD1WFAx
	m94Bqm0UpzYqDe+psiNPaMRd3eCj/B8vvFm0j0OEGi44VABEA8tWSl+k3VVS4ozQDrVuoU2qhJA/7
	rh0/yAglB2wA7Z+/NSOFtHmtpP2MkA67LxMvCQLQ6jMfNG4T7YUIPfRZWe6A8RwIkTTj0p+0HqB4p
	O7wYSU/A==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzL8Y-000000016NN-0nyX;
	Thu, 18 Sep 2025 20:21:50 +0000
Message-ID: <dcbd2c62-5db8-4eb5-aa3a-532b33baaa61@infradead.org>
Date: Thu, 18 Sep 2025 13:21:49 -0700
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] ALSA: doc: add docs about improved quirk_flags in
 snd-usb-audio
To: cryolitia@uniontech.com, Jaroslav Kysela <perex@perex.cz>,
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250918-sound-v4-5-82cf8123d61c@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 9/18/25 2:24 AM, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> Just briefly described about the option.
> 
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> ---
>  Documentation/sound/alsa-configuration.rst | 108 ++++++++++++++++++++---------
>  1 file changed, 75 insertions(+), 33 deletions(-)
> 
> diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
> index a2fb8ed251dd0294e7a62209ca15d5c32c6adfae..efffe3d534beeddcb6a47ac27a24defb6879f534 100644
> --- a/Documentation/sound/alsa-configuration.rst
> +++ b/Documentation/sound/alsa-configuration.rst
> @@ -2297,39 +2297,81 @@ skip_validation
>      of the unit descriptor instead of a driver probe error, so that we
>      can check its details.
>  quirk_flags
> -    Contains the bit flags for various device specific workarounds.
> -    Applied to the corresponding card index.
> -
> -        * bit 0: Skip reading sample rate for devices
> -        * bit 1: Create Media Controller API entries
> -        * bit 2: Allow alignment on audio sub-slot at transfer
> -        * bit 3: Add length specifier to transfers
> -        * bit 4: Start playback stream at first in implement feedback mode
> -        * bit 5: Skip clock selector setup
> -        * bit 6: Ignore errors from clock source search
> -        * bit 7: Indicates ITF-USB DSD based DACs
> -        * bit 8: Add a delay of 20ms at each control message handling
> -        * bit 9: Add a delay of 1-2ms at each control message handling
> -        * bit 10: Add a delay of 5-6ms at each control message handling
> -        * bit 11: Add a delay of 50ms at each interface setup
> -        * bit 12: Perform sample rate validations at probe
> -        * bit 13: Disable runtime PM autosuspend
> -        * bit 14: Ignore errors for mixer access
> -        * bit 15: Support generic DSD raw U32_BE format
> -        * bit 16: Set up the interface at first like UAC1
> -        * bit 17: Apply the generic implicit feedback sync mode
> -        * bit 18: Don't apply implicit feedback sync mode
> -        * bit 19: Don't closed interface during setting sample rate
> -        * bit 20: Force an interface reset whenever stopping & restarting
> -          a stream
> -        * bit 21: Do not set PCM rate (frequency) when only one rate is
> -          available for the given endpoint.
> -        * bit 22: Set the fixed resolution 16 for Mic Capture Volume
> -        * bit 23: Set the fixed resolution 384 for Mic Capture Volume
> -        * bit 24: Set minimum volume control value as mute for devices
> -          where the lowest playback value represents muted state instead
> -          of minimum audible volume
> -        * bit 25: Be similar to bit 24 but for capture streams
> +    The option provides a refined and flexible control for applying quirk
> +    flags.  It allows to specify the quirk flags for each device, and could

                                                                     and may
or: and can

> +    be modified dynamically via sysfs.
> +    The old usage accepts an array of integers, each of which apply quirk

                                                                 applies

> +    flags on the device in the order of probing.
> +    e.g. ``quirk_flags=0x01,0x02`` applies get_sample_rate to the first

       E.g.,

> +    device, and share_media_device to the second device.
> +    The new usage accepts a string in the format of
> +    ``VID1:PID1:FLAGS1;VID2:PID2:FLAGS2;...``, where ``VIDx`` and ``PIDx``
> +    specify the device, and ``FLAGSx`` specify the flags to be applied.
> +    ``VIDx`` and ``PIDx`` are 4-digit hexadecimal numbers, and could be

                                                           s/could/may/

> +    specified as ``*`` to match any value.  ``FLAGSx`` could be a set of

                                                      s/could/may/

> +    flags given by name, separated by ``|``, or a hexadecimal number
> +    representing the bit flags.  The available flag names are listed above.

                                                              s/above/below/ ?

> +    An exclamation mark could be prefixed to a flag name to negate the flag.
                       s/could/may/

> +    For example, ``1234:abcd:mixer_playback_min_mute|!ignore_ctl_error;*:*:0x01;``

What happens if the trailing (ending) ';' is omitted?

> +    applies the ``mixer_playback_min_mute`` flag and clears the
> +    ``ignore_ctl_error`` flag for the device 1234:abcd, and applies the
> +    ``skip_sample_rate`` flag for all devices.
> +
> +        * bit 0: ``get_sample_rate``
> +          Skip reading sample rate for devices

get vs Skip is a little confusing.

> +        * bit 1: ``share_media_device``
> +          Create Media Controller API entries
> +        * bit 2: ``align_transfer``
> +          Allow alignment on audio sub-slot at transfer
> +        * bit 3: ``tx_length``
> +          Add length specifier to transfers
> +        * bit 4: ``playback_first``
> +          Start playback stream at first in implement feedback mode
> +        * bit 5: ``skip_clock_selector``
> +          Skip clock selector setup
> +        * bit 6: ``ignore_clock_source``
> +          Ignore errors from clock source search
> +        * bit 7: ``itf_usb_dsd_dac``
> +          Indicates ITF-USB DSD based DACs

                               DSD-based

> +        * bit 8: ``ctl_msg_delay``
> +          Add a delay of 20ms at each control message handling
> +        * bit 9: ``ctl_msg_delay_1m``
> +          Add a delay of 1-2ms at each control message handling
> +        * bit 10: ``ctl_msg_delay_5m``
> +          Add a delay of 5-6ms at each control message handling
> +        * bit 11: ``iface_delay``
> +          Add a delay of 50ms at each interface setup
> +        * bit 12: ``validate_rates``
> +          Perform sample rate validations at probe
> +        * bit 13: ``disable_autosuspend``
> +          Disable runtime PM autosuspend
> +        * bit 14: ``ignore_ctl_error``
> +          Ignore errors for mixer access
> +        * bit 15: ``dsd_raw``
> +          Support generic DSD raw U32_BE format
> +        * bit 16: ``set_iface_first``
> +          Set up the interface at first like UAC1
> +        * bit 17: ``generic_implicit_fb``
> +          Apply the generic implicit feedback sync mode
> +        * bit 18: ``skip_implicit_fb``
> +          Don't apply implicit feedback sync mode
> +        * bit 19: ``iface_skip_close``
> +          Don't closed interface during setting sample rate

                   close

> +        * bit 20: ``force_iface_reset``
> +          Force an interface reset whenever stopping & restarting a stream
> +        * bit 21: ``fixed_rate``
> +          Do not set PCM rate (frequency) when only one rate is available
> +          for the given endpoint
> +        * bit 22: ``mic_res_16``
> +          Set the fixed resolution 16 for Mic Capture Volume
> +        * bit 23: ``mic_res_384``
> +          Set the fixed resolution 384 for Mic Capture Volume
> +        * bit 24: ``mixer_playback_min_mute``
> +          Set minimum volume control value as mute for devices where the
> +          lowest playback value represents muted state instead of minimum
> +          audible volume
> +        * bit 25: ``mixer_capture_min_mute``
> +          Be similar to bit 24 but for capture streams

             Similar to

>  
>  This module supports multiple devices, autoprobe and hotplugging.
>  
> Are all of these quirks used on various devices or are some of these
just implemented just in case they are needed in the future?thanks.
-- 
~Randy

