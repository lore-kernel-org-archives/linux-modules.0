Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BEB2FFDF6;
	Thu, 18 Sep 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187475; cv=none; b=t210QE9tsfrpM16uNirq83R/Log2oBJpylja9ZebX1oiXjc0U4jOrVidwDKlZ697WIMtuERPTdIf1OshuZoKRCtpLCR2ZVyxwzE/w000Qis2i+QtLd7kRKNsKv9EPxoc6uhOR8v9QjJnvvHfXUKFjxCS8HHi6t7UDyGF0y58ZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187475; c=relaxed/simple;
	bh=JOZL5aKeUQhPAF06ngc+zti+EoNjmnWL/H0POmJ6+t0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3daI+qVHeCcmAK9FR3fBLJQTGcAXf+x2dku2W6a4f+0VZE9V9NxeF0Tpm53guXQW4+3W6NuE3jy5VtXdkgmNFDZtnEaeAYuUVndKQ4mcOdPPXiTRJWDBdfvtvEBlCkOupnj8mAkZrYQlegFnqjCiiLVwt3vaSyu6KcMTZLnpJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJX4H8Gf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJX4H8Gf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4002AC4CEFC;
	Thu, 18 Sep 2025 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758187475;
	bh=JOZL5aKeUQhPAF06ngc+zti+EoNjmnWL/H0POmJ6+t0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QJX4H8GfhNfSv24n8Gmm3caIv8OYFghO7g8VXR0LhMaRYnltDt0I/21mGuF7HsFiK
	 3+FwU7RcgOOaZBplnu/uqU57HspHnjEL8rRLqAEXFQahItgAxIe6ipIyoDpWS1Zrma
	 mborJE4Xp/mCAmTpyt0KGrsG/QLo4GVce9XxK0SsqLGcnvJEdekP3iqdPEUOiwc3kN
	 fTP6U76dVvHliuBWp6gJEza3X2flN8Ac4CI2XxyAiuzqrgPGutCdIO5FeF0LJxvSh5
	 4Rm55ILqtnNtoFbjYxwMQPTpWvdtGdnYeCgpGNxPgHO9PfbZBNforv6IkYkNfwggto
	 gBJzyt+UWem7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C88CAC59A;
	Thu, 18 Sep 2025 09:24:35 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Thu, 18 Sep 2025 17:24:32 +0800
Subject: [PATCH v4 3/5] ALSA: usb-audio: improve module param quirk_flags
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-sound-v4-3-82cf8123d61c@uniontech.com>
References: <20250918-sound-v4-0-82cf8123d61c@uniontech.com>
In-Reply-To: <20250918-sound-v4-0-82cf8123d61c@uniontech.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>
Cc: linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Feng Yuan <fengyuan@uniontech.com>, qaqland <anguoli@uniontech.com>, 
 kernel@uniontech.com, linux-modules@vger.kernel.org, 
 Cryolitia PukNgae <cryolitia@uniontech.com>, Takashi Iwai <tiwai@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758187473; l=6882;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=q+HMwyqe4+9HaNuLRBYI9H0ocDi9G5hhy1QWgS3l+Dk=;
 b=Lk79LX0opB34NbnQqKcphq22zcwFWuPVg1e5CQkFwZwYawmOXd/t4jdE0SAolNjf8Ru2M6hqb
 guN5zMX7USFDZl5s+LFw84U/F76u+MtAnM5AP4SlXFrgBwDM6WoGFCA
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

For apply and unapply quirk flags more flexibly though param

Co-developed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/usb/card.c     |   9 ++--
 sound/usb/quirks.c   | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 sound/usb/quirks.h   |   3 +-
 sound/usb/usbaudio.h |   3 ++
 4 files changed, 126 insertions(+), 8 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 0265206a8e8cf31133e8463c98fe0497d8ace89e..5837677effa1787ef9d7d02714c3ae43b1a8bc79 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -73,8 +73,8 @@ static bool lowlatency = true;
 static char *quirk_alias[SNDRV_CARDS];
 static char *delayed_register[SNDRV_CARDS];
 static bool implicit_fb[SNDRV_CARDS];
-static unsigned int quirk_flags[SNDRV_CARDS];
 
+char *quirk_flags[SNDRV_CARDS];
 bool snd_usb_use_vmalloc = true;
 bool snd_usb_skip_validation;
 
@@ -103,7 +103,7 @@ module_param_array(delayed_register, charp, NULL, 0444);
 MODULE_PARM_DESC(delayed_register, "Quirk for delayed registration, given by id:iface, e.g. 0123abcd:4.");
 module_param_array(implicit_fb, bool, NULL, 0444);
 MODULE_PARM_DESC(implicit_fb, "Apply generic implicit feedback sync mode.");
-module_param_array(quirk_flags, uint, NULL, 0444);
+module_param_array(quirk_flags, charp, NULL, 0444);
 MODULE_PARM_DESC(quirk_flags, "Driver quirk bit flags.");
 module_param_named(use_vmalloc, snd_usb_use_vmalloc, bool, 0444);
 MODULE_PARM_DESC(use_vmalloc, "Use vmalloc for PCM intermediate buffers (default: yes).");
@@ -750,10 +750,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	INIT_LIST_HEAD(&chip->midi_v2_list);
 	INIT_LIST_HEAD(&chip->mixer_list);
 
-	if (quirk_flags[idx])
-		chip->quirk_flags = quirk_flags[idx];
-	else
-		snd_usb_init_quirk_flags(chip);
+	snd_usb_init_quirk_flags(idx, chip);
 
 	card->private_free = snd_usb_audio_free;
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 94854f352b1702b491e1bf3c8b769f7088e03976..4dc2464133e934e48b1fa613884a8a0ebdaff91d 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2502,7 +2502,7 @@ u32 snd_usb_quirk_flags_from_name(char *name)
 	return flag;
 }
 
-void snd_usb_init_quirk_flags(struct snd_usb_audio *chip)
+void snd_usb_init_quirk_flags_table(struct snd_usb_audio *chip)
 {
 	const struct usb_audio_quirk_flags_table *p;
 
@@ -2537,3 +2537,120 @@ void snd_usb_init_quirk_flags(struct snd_usb_audio *chip)
 		}
 	}
 }
+
+void snd_usb_init_quirk_flags(int idx, struct snd_usb_audio *chip)
+{
+	u16 chip_vid = USB_ID_VENDOR(chip->usb_id);
+	u16 chip_pid = USB_ID_PRODUCT(chip->usb_id);
+	u32 mask_flags, unmask_flags, bit;
+	char *val, *p, *field, *flag;
+	bool is_unmask;
+	u16 vid, pid;
+	size_t i;
+
+	/* old style option found: the position-based integer value */
+	if (quirk_flags[idx] &&
+	    !kstrtou32(quirk_flags[idx], 0, &chip->quirk_flags)) {
+		usb_audio_dbg(chip,
+			      "Set quirk flags 0x%x from param based on position %d for device %04x:%04x\n",
+			      chip->quirk_flags, idx,
+			      USB_ID_VENDOR(chip->usb_id),
+			      USB_ID_PRODUCT(chip->usb_id));
+		return;
+	}
+
+	/* take the default quirk from the quirk table */
+	snd_usb_init_quirk_flags_table(chip);
+
+	/* add or correct quirk bits from options */
+	for (i = 0; i < ARRAY_SIZE(quirk_flags); i++) {
+		if (!quirk_flags[i] || !*quirk_flags[i])
+			break;
+
+		val = kstrdup(quirk_flags[i], GFP_KERNEL);
+
+		if (!val) {
+			pr_err("snd_usb_audio: Error allocating memory while parsing quirk_flags\n");
+			return;
+		}
+
+		for (p = val; p && *p;) {
+			/* Each entry consists of VID:PID:flags */
+			field = strsep(&p, ":");
+			if (!field)
+				break;
+
+			if (strcmp(field, "*") == 0)
+				vid = 0;
+			else if (kstrtou16(field, 16, &vid))
+				break;
+
+			field = strsep(&p, ":");
+			if (!field)
+				break;
+
+			if (strcmp(field, "*") == 0)
+				pid = 0;
+			else if (kstrtou16(field, 16, &pid))
+				break;
+
+			field = strsep(&p, ";");
+			if (!field || !*field)
+				break;
+
+			if ((vid != 0 && vid != chip_vid) ||
+			    (pid != 0 && pid != chip_pid))
+				continue;
+
+			/* Collect the flags */
+			mask_flags = 0;
+			unmask_flags = 0;
+			while (field && *field) {
+				flag = strsep(&field, "|");
+
+				if (!flag)
+					break;
+
+				if (*flag == '!') {
+					is_unmask = true;
+					flag++;
+				} else {
+					is_unmask = false;
+				}
+
+				if (!kstrtou32(flag, 16, &bit)) {
+					if (is_unmask)
+						unmask_flags |= bit;
+					else
+						mask_flags |= bit;
+
+					break;
+				}
+
+				bit = snd_usb_quirk_flags_from_name(flag);
+
+				if (bit) {
+					if (is_unmask)
+						unmask_flags |= bit;
+					else
+						mask_flags |= bit;
+				} else {
+					pr_warn("snd_usb_audio: unknown flag %s while parsing param quirk_flags\n",
+						field);
+				}
+			}
+
+			chip->quirk_flags &= ~unmask_flags;
+			chip->quirk_flags |= mask_flags;
+			usb_audio_dbg(chip,
+				      "Set quirk flags (mask 0x%x, unmask 0x%x, finally 0x%x) from param for device %04x:%04x\n",
+				      mask_flags,
+				      unmask_flags,
+				      chip->quirk_flags,
+				      USB_ID_VENDOR(chip->usb_id),
+				      USB_ID_PRODUCT(chip->usb_id));
+		}
+
+		kfree(val);
+	}
+}
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index bd5baf2b193a1985f3a0e52bf4a77ca741364769..0dc8c04afeffe76e1219c71a8fe2e4b66624b48f 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -48,7 +48,8 @@ void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
 					  struct audioformat *fp,
 					  int stream);
 
-void snd_usb_init_quirk_flags(struct snd_usb_audio *chip);
+void snd_usb_init_quirk_flags_table(struct snd_usb_audio *chip);
+void snd_usb_init_quirk_flags(int idx, struct snd_usb_audio *chip);
 
 const char *snd_usb_quirk_flag_find_name(unsigned long flag);
 u32 snd_usb_quirk_flags_from_name(char *name);
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 0a22cb4a02344b2dcf4009c560a759f2da25ca67..73564cd68ebf101291440d0171eb81c220c6f5e2 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -7,6 +7,8 @@
  *   Copyright (c) 2002 by Takashi Iwai <tiwai@suse.de>
  */
 
+ #include <sound/core.h>
+
 /* handling of USB vendor/product ID pairs as 32-bit numbers */
 #define USB_ID(vendor, product) (((unsigned int)(vendor) << 16) | (product))
 #define USB_ID_VENDOR(id) ((id) >> 16)
@@ -162,6 +164,7 @@ DEFINE_CLASS(snd_usb_lock, struct __snd_usb_lock,
 	     __snd_usb_unlock_shutdown(&(_T)), __snd_usb_lock_shutdown(chip),
 	     struct snd_usb_audio *chip)
 
+extern char *quirk_flags[SNDRV_CARDS];
 extern bool snd_usb_use_vmalloc;
 extern bool snd_usb_skip_validation;
 

-- 
2.51.0


