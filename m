Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB7332A5A
	for <linux-modules@vger.kernel.org>; Wed, 17 Sep 2025 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116746; cv=none; b=sQ+KKmGUN/PBSRcDou+ZLX7I67qXG3MgYy6jYdGipWBL2UnzpqMHvIzakYiIwtAqGfj8veu/AsBIi/eTwzQRU4sMQTL9dNFAnknBRwPDPjobYFJn+vgy6LFLdoz2ssebVdkOoYyRenKff7oMrNQ253aWTgltQXmkqVOBAJvxfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116746; c=relaxed/simple;
	bh=pttNoyrVMO9HIku9QnhGRBuzxeRAlRZhE0Pn0ymP/IQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1PUuBYHboObZfI0Oq3WI3pEGSsxXR70hMIM1IgbRF41hSIezaBYkCa2S1xpzPx6gLi+TAzgj00FPi1h8B8D3iV7NkIerJ2GAgWcQ5mTpLHqcirLU+ZWDMk+IzWQl6Mp2jjFUr/AMeN7vj0C13n8RPTix19cuFfj7dRkaGnRPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cL4dI1cm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2EAcp0KX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cL4dI1cm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2EAcp0KX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cL4dI1cm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2EAcp0KX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cL4dI1cm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2EAcp0KX"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5DEFA2017A;
	Wed, 17 Sep 2025 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758116741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13Ej0a5LcZRESyka9zE9AK+QSaGitNj9CQUgrUKtJJo=;
	b=cL4dI1cmxNNbqLFkGrb4NyRAZTyFbeuZF+xxNpPZ2N81pZalZxmq4CWKUrNn6i+rA6ubuf
	AEG6oFms1U1siTsakc4T4ZxZTSzkr6joyvt/dKdjDRGoArAt0zs+OP07UBSe+bjOYutorx
	XP6Rlp6EVfMgu53jEne01ufQCs5fNmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758116741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13Ej0a5LcZRESyka9zE9AK+QSaGitNj9CQUgrUKtJJo=;
	b=2EAcp0KXYGQcDdwOmvXzIJ8hQvle/WjeSQ64vwBKJQRt2kfS1NFNz8daDq7mZlF33rHkih
	NVNazWta+c4320AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cL4dI1cm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2EAcp0KX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758116741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13Ej0a5LcZRESyka9zE9AK+QSaGitNj9CQUgrUKtJJo=;
	b=cL4dI1cmxNNbqLFkGrb4NyRAZTyFbeuZF+xxNpPZ2N81pZalZxmq4CWKUrNn6i+rA6ubuf
	AEG6oFms1U1siTsakc4T4ZxZTSzkr6joyvt/dKdjDRGoArAt0zs+OP07UBSe+bjOYutorx
	XP6Rlp6EVfMgu53jEne01ufQCs5fNmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758116741;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=13Ej0a5LcZRESyka9zE9AK+QSaGitNj9CQUgrUKtJJo=;
	b=2EAcp0KXYGQcDdwOmvXzIJ8hQvle/WjeSQ64vwBKJQRt2kfS1NFNz8daDq7mZlF33rHkih
	NVNazWta+c4320AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B968B137C3;
	Wed, 17 Sep 2025 13:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D/tkK4S7ymjGegAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 17 Sep 2025 13:45:40 +0000
Date: Wed, 17 Sep 2025 15:45:40 +0200
Message-ID: <87ms6tchvf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: cryolitia@uniontech.com,
	Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
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
Subject: Re: [PATCH v3 3/4] ALSA: usb-audio: add module param device_quirk_flags
In-Reply-To: <20250917-sound-v3-3-92ebe9472a0a@uniontech.com>
References: <20250917-sound-v3-0-92ebe9472a0a@uniontech.com>
	<20250917-sound-v3-3-92ebe9472a0a@uniontech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5DEFA2017A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[cryolitia.uniontech.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -2.01

On Wed, 17 Sep 2025 14:46:42 +0200,
Cryolitia PukNgae via B4 Relay wrote:
> 
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> For apply and unapply quirk flags more flexibly though param and sysfs
> 
> Co-developed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

I think an easier approach would be to rather parse the string value
at each time when probing a device and seeking for options.

That is, let's code without a mutex at first (for the permission
0444):

void snd_usb_init_dynamic_quirks(int idx, struct snd_usb_audio *chip)
{
	....
	/* old style option found: the position-based integer value */
	if (quirk_flags[idx] &&
	    !kstrtou32(quirk_flags[idx], 0, &chip->quirk_flags)) {
		usb_audio_dbg(....);
		return;
	}

	/* take the default quirk from the quirk table */
	snd_usb_init_quirk_flags(chip);

	for (i = 0; i < ARRAY_SIZE(quirk_flags); i++) {
		if (quirk_flags[i] && *quirk_flags[i]) {
			err = parse_quirk_option(chip, quirk_flags[i]);
			if (err < 0)
				return;
		}
	}
}

and the parser would be something like:

static int parse_quirk_option(struct snd_usb_audio *chip, const char *str)
{
	char *val __free(kfree) = NULL;
	char *field;
	int pid, vid;

	if (!strchr(str, ':'))
		return 0;

	val = kstrdup(str, GFP_KERNEL);
	if (!val)
		return -ENOMEM;

	/* Each entry consists of VID:PID:flags */
	field = strsep(&p, ":");
	if (!field)
		return 0;
	if (strcmp(field, "*") == 0)
		vid = 0;
	else if (kstrtou16(field, 16, &vid))
		return 0; // can spew warning message, too

	field = strsep(&p, ":");
	if (!field)
		return 0;
	if (strcmp(field, "*") == 0)
		pid = 0;
	else if (kstrtou16(field, 16, &pid))
		return 0; // can spew warning message, too

	.... // evaluate the tokens, set or clear chip->quirk_flags accordingly
	return 0;
}

So you can just use the normal charp type for the parameters.

Once after this working, we may want to allow the dynamic module
parameter change.  Then make the parameter a special type just to take
the device_quirk_mutex at set callback, while the set callback simply
calls parm_set_charp() for the rest.  For get and free callbacks, we
can use param_get_charp() and param_free_charp() as is.
Finally, snd_usb_init_dynamic_quirks() takes the device_quirk_mutex,
and that's all.  No need for heavy cleanups or linked list handling.

Of course, it's a bit inefficient from the performance POV, but the
device probing is rather a very rare event, so the speed doesn't
matter at all.


thanks,

Takashi
