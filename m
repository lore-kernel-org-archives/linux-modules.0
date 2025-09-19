Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE7215077
	for <linux-modules@vger.kernel.org>; Fri, 19 Sep 2025 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286074; cv=none; b=fWs3Y9coDHmSNRDkZKCPHvStl/KOGPpwzEu6SLwj8wwzTPOmWMzVGCgPIsX1mcqG4UQBrtzcOXrJLdxp+CVV2P2LDktVsgt/UoBBx5Nr3n7IhIsJd88VA1u6w0GIhfBBTCyVvZ4VLmnvumG0+/JxVGBq+5o47g6nHUnkBVLqeOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286074; c=relaxed/simple;
	bh=iNxcvG6B7+iDbjP3eeNJDrtINQljCA+BpTp4TS4X6DU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGH41xtcfDgpxzOSEo7h8zv+pXk3hphOAlfJZVu52A9hAXYF3w6vxc6Bw+FAlY+4Mp+fW0XR0jx6+jZ1s7NbLGNRtUUxBkAK1fhNqZlOB9zWxRA5nhBlT/x7RuuBKSUb0oQHTPES9mkxfXKjRXiUo3LciX64+IU9ed5XfjoDgB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y/UF8xXE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S7iKHHi3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xaPwq3kP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zMw0MRkS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y/UF8xXE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S7iKHHi3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xaPwq3kP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zMw0MRkS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 180AB1F7D9;
	Fri, 19 Sep 2025 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758286063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zBiZKKxnPHMmQmNm1unV7jDvvhBaThzW9jKejI52qTw=;
	b=Y/UF8xXETeEW83Q/DgOSsD4SL6rV31h793/tzfWVyU+8wIRjIESz27y4H2iawXnRsfNGwL
	1QDvv3o+juw69LEPQuwz68RG0AgAbohGtTmybiMU5rBE/WlZkwSZf/Oe73360lwEUGYk0P
	lRF5jUtMAN90UZFppKhVlclxGi2o4p0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758286063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zBiZKKxnPHMmQmNm1unV7jDvvhBaThzW9jKejI52qTw=;
	b=S7iKHHi3fvDdgUJqgQ03ZxOCsEHB0mF053q7Xdg90YwAmpCWSkl0EuWfr2IQddu9qe7mTd
	vEmLUIjvWiMViVDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758286062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zBiZKKxnPHMmQmNm1unV7jDvvhBaThzW9jKejI52qTw=;
	b=xaPwq3kPsMCYqrbS0e8aGYzqdDFV4lykmBS3wI4Pl0eZhMo8EHtNpkvq3ZJPKzHpOdmyMr
	iVWiOWfWF2fDj0M8QVkBeUxiZlfHMTrgudG9hRfiYe3CwS/Vn6Gk9j1srycw2bWMjxOzhY
	1KEQfZSIXiyB/xbLDdeA+HD8OqG3eCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758286062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zBiZKKxnPHMmQmNm1unV7jDvvhBaThzW9jKejI52qTw=;
	b=zMw0MRkS572Pe/PFWODVhBKpHki+CvqRQE2P7Whd8ihEjdM9ZTurjMPknIijvBTQQxRrI7
	8zRnJXXcL7/IySAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 648DE13A78;
	Fri, 19 Sep 2025 12:47:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qGfzFe1QzWgJAwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Sep 2025 12:47:41 +0000
Date: Fri, 19 Sep 2025 14:47:40 +0200
Message-ID: <87qzw28v83.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: cryolitia@uniontech.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Nie Cheng <niecheng1@uniontech.com>,
	Zhan Jun <zhanjun@uniontech.com>,
	Feng Yuan <fengyuan@uniontech.com>,
	qaqland <anguoli@uniontech.com>,
	kernel@uniontech.com,
	linux-modules@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v4 3/5] ALSA: usb-audio: improve module param quirk_flags
In-Reply-To: <20250918-sound-v4-3-82cf8123d61c@uniontech.com>
References: <20250918-sound-v4-0-82cf8123d61c@uniontech.com>
	<20250918-sound-v4-3-82cf8123d61c@uniontech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,uniontech.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Thu, 18 Sep 2025 11:24:32 +0200,
Cryolitia PukNgae via B4 Relay wrote:
> 
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> For apply and unapply quirk flags more flexibly though param
> 
> Co-developed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> ---
>  sound/usb/card.c     |   9 ++--
>  sound/usb/quirks.c   | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  sound/usb/quirks.h   |   3 +-
>  sound/usb/usbaudio.h |   3 ++
>  4 files changed, 126 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 0265206a8e8cf31133e8463c98fe0497d8ace89e..5837677effa1787ef9d7d02714c3ae43b1a8bc79 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -73,8 +73,8 @@ static bool lowlatency = true;
>  static char *quirk_alias[SNDRV_CARDS];
>  static char *delayed_register[SNDRV_CARDS];
>  static bool implicit_fb[SNDRV_CARDS];
> -static unsigned int quirk_flags[SNDRV_CARDS];
>  
> +char *quirk_flags[SNDRV_CARDS];

My preference is to keep this static, but pass the string value to a
function.  That is, define snd_usb_init_quirk_flags() in main.c:

static void snd_usb_init_quirk_flags(struct snd_usb_audio *chip, int indx)
{
	/* old style option found: the position-based integer value */
	if (quirk_flags[idx] &&
	    !kstrtou32(quirk_flags[idx], 0, &chip->quirk_flags)) {
		usb_audio_dbg(chip,
			      "Set quirk flags 0x%x from param based on position %d for device %04x:%04x\n",
			      chip->quirk_flags, idx,
			      USB_ID_VENDOR(chip->usb_id),
			      USB_ID_PRODUCT(chip->usb_id));
		return;
	}

	/* take the default quirk from the quirk table */
	snd_usb_init_quirk_flags_table(chip);

	/* add or correct quirk bits from options */
	for (i = 0; i < ARRAY_SIZE(quirk_flags); i++) {
		char *val __free(kfree) = NULL;

		if (!quirk_flags[i] || !*quirk_flags[i])
			continue;
		
		val = kstrdup(quirk_flags[i], GFP_KERNEL);
		if (!val)
			return;

		snd_usb_parse_quirk_string(chip, val);
	}
}
	
static int snd_usb_audio_create(....)
{
	....
	snd_usb_init_quirk_flags(chip, idx);
	....
}

The function snd_usb_parse_quirk_string() is defined in quirks.c,

void snd_usb_parse_quirk_string(struct snd_usb_audio *chip, char *val)
{
	for (p = val; p && *p;) {
		/* Each entry consists of VID:PID:flags */
		field = strsep(&p, ":");
		if (!field)
			break;
		.....
	}
}


thanks,

Takashi
