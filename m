Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE82F7ABF;
	Wed, 17 Sep 2025 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113203; cv=none; b=u4cQXcwLqB6ZZ/1MI4en8Vj/aVo5IpmqXmOvtak3TuDAEncLx0Bruz8beFVOnNAvoGGqgakXA2LcFb6xedWewheo7bEkLdHjkPeisX7OdFAkEbeX7SJhsj77FrqDqQ8P6iWM4riGbKm+83qI95ggLmsstnAQ9DM1T5bTNAYPWRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113203; c=relaxed/simple;
	bh=0AYh4Kq94+K9Q9GhBTgVtjkUCdxvjg6DMvyhydU1efM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XnmOkcZZWAFYp0UWJ6vH4wHjeSA3/dYYEH/kIf2PQ0tXsJpladBy5qj1mD6/DYE6rrK72nLpEC2iv4D0obiA/OqzoTD7ZZh/kwXQyGBeJUxe0e9lngvVrKDErtyZrylYSffHYDxFyZIbI0DxyHdQI93oGzuXdXVefJxlBY5mOgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWle+E5w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWle+E5w"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA498C4CEFB;
	Wed, 17 Sep 2025 12:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758113202;
	bh=0AYh4Kq94+K9Q9GhBTgVtjkUCdxvjg6DMvyhydU1efM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NWle+E5wXetBRQRYLhnQzOhklLQx0VhOwzFXt9HFfNkVmenmQUe67VJem66I1rPVh
	 daA01cICLzz0Yv47vXsTcSYvLz2cXxXlM4mINFARpLf0KH7W/f5oR6nuBHXbot9l+l
	 QSOsr0NxQ8IMFfosK0/nGRKd9uQYS8DnVgg4z49QeOh82uRVh06uAACxB8bCu45bA/
	 +okrwlZJajoon0vCW20CK2nsBJ/NxzF9QziyRdyyp2JhM1+tJOH8O5xVdc+7aTq+sv
	 ppC0PoM/kpTZW2SrkSt1h4jQX4QoDmdZ2JGZMYxWv+628dvVkFGO8TsVW1n8u0bGNB
	 9XZUk048We4wg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6B8CAC5A0;
	Wed, 17 Sep 2025 12:46:42 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Wed, 17 Sep 2025 20:46:41 +0800
Subject: [PATCH v3 2/4] param: export param_array related functions
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-sound-v3-2-92ebe9472a0a@uniontech.com>
References: <20250917-sound-v3-0-92ebe9472a0a@uniontech.com>
In-Reply-To: <20250917-sound-v3-0-92ebe9472a0a@uniontech.com>
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
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758113201; l=2799;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=Iu09dllz6TNtY0M5KhKHic/tph0IN8w4KA3fww/CJfM=;
 b=xHObROBLoDrbEdXtHH8AJIwWIJ1HQ9WuXZhRlRJnP/H9QWTFWCK0FutgCIqkRq/slWPyyu8rJ
 jmJhyYrMp9EC0o3yyOy7Cuj65GSLy6YUpc8fSNy1zp9eey5XqDTpEd6
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

- int param_array_set(const char *val, const struct kernel_param *kp);
- int param_array_get(char *buffer, const struct kernel_param *kp);
- void param_array_free(void *arg);

It would be helpful for the new module param we designed in
snd_usb_audio, in order to run additional custom codes when params
are set in runtime, and re-use the extisted codes in param.c

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 include/linux/moduleparam.h | 3 +++
 kernel/params.c             | 9 ++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 3a25122d83e2802e6e6a1475a52816251498b26a..4ef09ad2004789855bd21783029c653fac94b9dd 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -593,6 +593,9 @@ enum hwparam_type {
 
 
 extern const struct kernel_param_ops param_array_ops;
+extern int param_array_set(const char *val, const struct kernel_param *kp);
+extern int param_array_get(char *buffer, const struct kernel_param *kp);
+extern void param_array_free(void *arg);
 
 extern const struct kernel_param_ops param_ops_string;
 extern int param_set_copystring(const char *val, const struct kernel_param *);
diff --git a/kernel/params.c b/kernel/params.c
index b96cfd693c9968012d42acb85611fee1acd47790..a936e018a1c6d0bf2b6b4566f80751840366f652 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -462,7 +462,7 @@ static int param_array(struct module *mod,
 	return 0;
 }
 
-static int param_array_set(const char *val, const struct kernel_param *kp)
+int param_array_set(const char *val, const struct kernel_param *kp)
 {
 	const struct kparam_array *arr = kp->arr;
 	unsigned int temp_num;
@@ -471,8 +471,9 @@ static int param_array_set(const char *val, const struct kernel_param *kp)
 			   arr->elemsize, arr->ops->set, kp->level,
 			   arr->num ?: &temp_num);
 }
+EXPORT_SYMBOL(param_array_set);
 
-static int param_array_get(char *buffer, const struct kernel_param *kp)
+int param_array_get(char *buffer, const struct kernel_param *kp)
 {
 	int i, off, ret;
 	const struct kparam_array *arr = kp->arr;
@@ -492,8 +493,9 @@ static int param_array_get(char *buffer, const struct kernel_param *kp)
 	buffer[off] = '\0';
 	return off;
 }
+EXPORT_SYMBOL(param_array_get);
 
-static void param_array_free(void *arg)
+void param_array_free(void *arg)
 {
 	unsigned int i;
 	const struct kparam_array *arr = arg;
@@ -502,6 +504,7 @@ static void param_array_free(void *arg)
 		for (i = 0; i < (arr->num ? *arr->num : arr->max); i++)
 			arr->ops->free(arr->elem + arr->elemsize * i);
 }
+EXPORT_SYMBOL(param_array_free);
 
 const struct kernel_param_ops param_array_ops = {
 	.set = param_array_set,

-- 
2.51.0


