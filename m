Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018B2FFDF7;
	Thu, 18 Sep 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187475; cv=none; b=AtXNrze27LoWEmk1GasEoH1/qoeeRs45w3MHLa8hZVTpb7y8iY9KDk5lKAgCosprLSajyRn0U28xcGaje2eR5drn5UQty7GSO9bU8I81rX7+LCXlgg8LIeA1pru6OfPcdpppFd9HvyzMUMb/ZIwQHwjaTinnDhneej/gwBC6BmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187475; c=relaxed/simple;
	bh=cZj0X4uXKE82QrzbmJRGUCqeyeFL4fGaR+wQomjtqLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxs62QwMCQygRmgNDueGQ81ZYe+Zf4YfDNqB2TCxKfZB34sqUhijIiRT35HhSQP7wjjp/D/zQUOBviWhXUHk9DSRUw5Ifmj810gjLmzxqvO+d20JeCGc9VOj1WkvqsHTQUYc4p3yGcD2vbwbsnT8U7vy8mxqcZ1PWBROq7FGxH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSTi7WEb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSTi7WEb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EA61C4CEFE;
	Thu, 18 Sep 2025 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758187475;
	bh=cZj0X4uXKE82QrzbmJRGUCqeyeFL4fGaR+wQomjtqLk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cSTi7WEbP3Iwi0bs6Z4ZTf5RMlYcB/lBRdkOdiL+CirGUiN0yaJ4Bgy1aNjH4jkus
	 Zk6WTm5+POD8lRVIeHrNYocVuQuK+xFYTny2if9eta0qFm83b/wgKEdK+nPjdw+be+
	 rqyHFdKaCwnon31oVFuuNNV5ZWxDQvXuCdMKu0EiTA92u5RA4Cgy50Gmtv6XVCoIoU
	 ljcGORpWebqPdTbxM7w5v83VFKZnuKX2WjWqyX8IGGCZ4CpWeCi4bnVx8jCKfHL/BF
	 PC2ATxCTbHTkTJwfHUBM0Gx8VWdWPAFdXDytBEBq0qyIixMPn4/rmZUMtCZvKCiL+2
	 5jlzKYM9sA9YA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4331FCAC5AA;
	Thu, 18 Sep 2025 09:24:35 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Thu, 18 Sep 2025 17:24:33 +0800
Subject: [PATCH v4 4/5] ALSA: usb-audio: make param quirk_flags change-able
 in runtime
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-sound-v4-4-82cf8123d61c@uniontech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758187473; l=4510;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=STeoGU+UtGOLSx8KmIDY0kU8k2ZAF7sipS6bLUIP9L4=;
 b=csi4J0NfBu9l3xWhCmiJYM3fyuFHZKpjb/whezESt9l9YSV6By4OYlEFKPQjoO9H6gFDpXdoe
 ngZikcAmm6PDBh29OexAfHPwugVCpd5xT9LBq2egvILVec5rjLaUUU/
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Developers now can change it during sysfs, without rebooting, for
debugging new buggy devices.

Co-developed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/usb/card.c     | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 sound/usb/quirks.c   |  9 +++++++--
 sound/usb/usbaudio.h |  2 ++
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 5837677effa1787ef9d7d02714c3ae43b1a8bc79..fd99df5949df826d97b3d2bc6d3137923ab4295d 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -103,13 +103,65 @@ module_param_array(delayed_register, charp, NULL, 0444);
 MODULE_PARM_DESC(delayed_register, "Quirk for delayed registration, given by id:iface, e.g. 0123abcd:4.");
 module_param_array(implicit_fb, bool, NULL, 0444);
 MODULE_PARM_DESC(implicit_fb, "Apply generic implicit feedback sync mode.");
-module_param_array(quirk_flags, charp, NULL, 0444);
-MODULE_PARM_DESC(quirk_flags, "Driver quirk bit flags.");
 module_param_named(use_vmalloc, snd_usb_use_vmalloc, bool, 0444);
 MODULE_PARM_DESC(use_vmalloc, "Use vmalloc for PCM intermediate buffers (default: yes).");
 module_param_named(skip_validation, snd_usb_skip_validation, bool, 0444);
 MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no).");
 
+/* protects quirk_flags */
+DEFINE_MUTEX(quirk_flags_mutex);
+
+static int quirk_flags_param_set(const char *value,
+				 const struct kernel_param *kp)
+{
+	int err;
+
+	mutex_lock(&quirk_flags_mutex);
+
+	memset(quirk_flags, 0, sizeof(quirk_flags));
+	err = param_array_set(value, kp);
+
+	mutex_unlock(&quirk_flags_mutex);
+
+	return err;
+}
+
+static int quirk_flags_param_get(char *buffer, const struct kernel_param *kp)
+{
+	int err;
+
+	mutex_lock(&quirk_flags_mutex);
+	err = param_array_get(buffer, kp);
+	mutex_unlock(&quirk_flags_mutex);
+
+	return err;
+}
+
+static void quirk_flags_param_free(void *arg)
+{
+	mutex_lock(&quirk_flags_mutex);
+	param_array_free(arg);
+	mutex_unlock(&quirk_flags_mutex);
+}
+
+static const struct kernel_param_ops quirk_flags_param_ops = {
+	.set = quirk_flags_param_set,
+	.get = quirk_flags_param_get,
+	.free = quirk_flags_param_free,
+};
+
+static struct kparam_array quirk_flags_param_array = {
+	.max = SNDRV_CARDS,
+	.elemsize = sizeof(char *),
+	.num = NULL,
+	.ops = &param_ops_charp,
+	.elem = &quirk_flags,
+};
+
+device_param_cb(quirk_flags, &quirk_flags_param_ops, &quirk_flags_param_array,
+		0644);
+MODULE_PARM_DESC(quirk_flags, "Add/modify USB audio quirks");
+
 /*
  * we keep the snd_usb_audio_t instances by ourselves for merging
  * the all interfaces on the same card as one sound device.
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 4dc2464133e934e48b1fa613884a8a0ebdaff91d..ba9ea94399e5a6e7e1711b2a9148c90f991f05cd 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2548,6 +2548,8 @@ void snd_usb_init_quirk_flags(int idx, struct snd_usb_audio *chip)
 	u16 vid, pid;
 	size_t i;
 
+	mutex_lock(&quirk_flags_mutex);
+
 	/* old style option found: the position-based integer value */
 	if (quirk_flags[idx] &&
 	    !kstrtou32(quirk_flags[idx], 0, &chip->quirk_flags)) {
@@ -2556,7 +2558,7 @@ void snd_usb_init_quirk_flags(int idx, struct snd_usb_audio *chip)
 			      chip->quirk_flags, idx,
 			      USB_ID_VENDOR(chip->usb_id),
 			      USB_ID_PRODUCT(chip->usb_id));
-		return;
+		goto unlock;
 	}
 
 	/* take the default quirk from the quirk table */
@@ -2571,7 +2573,7 @@ void snd_usb_init_quirk_flags(int idx, struct snd_usb_audio *chip)
 
 		if (!val) {
 			pr_err("snd_usb_audio: Error allocating memory while parsing quirk_flags\n");
-			return;
+			goto unlock;
 		}
 
 		for (p = val; p && *p;) {
@@ -2653,4 +2655,7 @@ void snd_usb_init_quirk_flags(int idx, struct snd_usb_audio *chip)
 
 		kfree(val);
 	}
+
+unlock:
+	mutex_unlock(&quirk_flags_mutex);
 }
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 73564cd68ebf101291440d0171eb81c220c6f5e2..40551946c20df8c17d306fddd8295ca3a2bfa702 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -168,6 +168,8 @@ extern char *quirk_flags[SNDRV_CARDS];
 extern bool snd_usb_use_vmalloc;
 extern bool snd_usb_skip_validation;
 
+extern struct mutex quirk_flags_mutex;
+
 /*
  * Driver behavior quirk flags, stored in chip->quirk_flags
  *

-- 
2.51.0


