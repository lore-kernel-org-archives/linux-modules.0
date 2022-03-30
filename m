Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAB0C433F5
	for <linux-modules@archiver.kernel.org>; Wed, 30 Mar 2022 21:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348430AbiC3VU0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 30 Mar 2022 17:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiC3VUY (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 30 Mar 2022 17:20:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00103633F
        for <linux-modules@vger.kernel.org>; Wed, 30 Mar 2022 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648675118; x=1680211118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zXAOc8E9sH1EJxtL0tgIeppjJOdj1Id80A5ljsrlYhc=;
  b=OlDJS+Z7LODSKpgDx0KVhxETTHOMoBOoAOt9yIQ6VEAXWrh1Z64kbVYn
   HyyrAwMvhRuyEciO/zDx4cC8owhWanHEorsqfvMG64NGU0oVfBE1QD/dm
   icLmezaogSnMVZHrhsCEXZ6vTpO2qL9ofJPutPb9qn0KqBT//3AWPzsIn
   BDJlI9P9x/mRtElW0yUmp9PzBor5niAJ/uS3kYIZHc5edyMQo+Vt/fXYn
   75cfTdEN3F3kConich9UwZHVEBQMKTzoN4IFgdQjo6+6Ma5AP3DrZQ5+D
   HN3uYPvKVNIJN/TP1fuhwGUBSME4QFqLB/NqaODpxqfximtaJC9/2xNRA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="241800974"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="241800974"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 14:18:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="547015117"
Received: from jlightca-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.134.52])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 14:18:36 -0700
Date:   Wed, 30 Mar 2022 14:18:36 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Saul Wold <saul.wold@windriver.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH] depmod: Add support for excluding a directory
Message-ID: <20220330211836.hfdc76wu57cvbidz@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220324170354.67733-1-saul.wold@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220324170354.67733-1-saul.wold@windriver.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hi Saul,

On Thu, Mar 24, 2022 at 10:03:54AM -0700, Saul Wold wrote:
>This adds support to depmod to enable a new exclude directive in
>the depmod.d/exclude.conf configuration file. Currently depmod
>already excludes directories named source or build. This change
>will allow additional directories like .debug to be excluded also
>via a new exclude directive.
>
>depmod.d/exclude.conf example:
>exclude	.debug
>
>Signed-off-by: Saul Wold <saul.wold@windriver.com>

Overall it looks good to me.

I'd not mention exclude.conf name and rather say depmod.d/*.conf like in
the man page. It's up to distros/users to use whatever name they wish.

>---
> man/depmod.d.xml | 14 +++++++++++++
> tools/depmod.c   | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 67 insertions(+)
>
>diff --git a/man/depmod.d.xml b/man/depmod.d.xml
>index b315e93..9ab790a 100644
>--- a/man/depmod.d.xml
>+++ b/man/depmod.d.xml
>@@ -131,6 +131,20 @@
>           </para>
>         </listitem>
>       </varlistentry>
>+      <varlistentry>
>+        <term>external <replaceable>excludedir</replaceable>
>+        </term>

wrong copy and paste?
>+        <listitem>
>+          <para>
>+            This specifies the trailing directories that will be excluded
>+            during the search for kernel modules.
>+          </para>
>+          <para>
>+	    The <replaceable>excludedir</replaceable> the trailing directory

s/the/is the/ ?

>+	    to exclude
>+          </para>
>+        </listitem>
>+      </varlistentry>
>     </variablelist>
>   </refsect1>
>
>diff --git a/tools/depmod.c b/tools/depmod.c
>index eb810b8..4ac758c 100644
>--- a/tools/depmod.c
>+++ b/tools/depmod.c
>@@ -458,6 +458,12 @@ struct cfg_external {
> 	char path[];
> };
>
>+struct cfg_exclude {
>+	struct cfg_exclude *next;
>+	size_t len;
>+	char exclude_dir[];
>+};
>+
> struct cfg {
> 	const char *kversion;
> 	char dirname[PATH_MAX];
>@@ -469,6 +475,7 @@ struct cfg {
> 	struct cfg_override *overrides;
> 	struct cfg_search *searches;
> 	struct cfg_external *externals;
>+	struct cfg_exclude *excludes;
> };
>
> static enum search_type cfg_define_search_type(const char *path)
>@@ -580,6 +587,31 @@ static void cfg_external_free(struct cfg_external *ext)
> 	free(ext);
> }
>
>+static int cfg_exclude_add(struct cfg *cfg, const char *path)
>+{
>+	struct cfg_exclude *exc;
>+	size_t len = strlen(path);
>+
>+	exc = malloc(sizeof(struct cfg_exclude) + len);

+ len + 1 as we want to store the \0 too.

>+	if (exc == NULL) {
>+		ERR("exclude add: out of memory\n");
>+		return -ENOMEM;
>+	}
>+	exc->len = len;
>+	memcpy(exc->exclude_dir, path, len);

len + 1

>+
>+	DBG("exclude add: %s\n", path);
>+
>+	exc->next = cfg->excludes;
>+	cfg->excludes = exc;
>+	return 0;
>+}
>+
>+static void cfg_exclude_free(struct cfg_exclude *exc)
>+{
>+	free(exc);
>+}
>+
> static int cfg_kernel_matches(const struct cfg *cfg, const char *pattern)
> {
> 	regex_t re;
>@@ -657,6 +689,11 @@ static int cfg_file_parse(struct cfg *cfg, const char *filename)
> 			}
>
> 			cfg_external_add(cfg, dir);
>+		} else if (streq(cmd, "exclude")) {
>+			const char *sp;
>+			while ((sp = strtok_r(NULL, "\t ", &saveptr)) != NULL) {
>+				cfg_exclude_add(cfg, sp);
>+			}
> 		} else if (streq(cmd, "include")
> 				|| streq(cmd, "make_map_files")) {
> 			INF("%s:%u: command %s not implemented yet\n",
>@@ -857,6 +894,12 @@ static void cfg_free(struct cfg *cfg)
> 		cfg->externals = cfg->externals->next;
> 		cfg_external_free(tmp);
> 	}
>+
>+	while (cfg->excludes) {
>+		struct cfg_exclude *tmp = cfg->excludes;
>+		cfg->excludes = cfg->excludes->next;
>+		cfg_exclude_free(tmp);
>+	}
> }
>
>
>@@ -1239,12 +1282,22 @@ static int depmod_modules_search_dir(struct depmod *depmod, DIR *d, size_t basel
> 		const char *name = de->d_name;
> 		size_t namelen;
> 		uint8_t is_dir;
>+	        struct cfg_exclude *exc;
>+		int exclude = 0;
>
> 		if (name[0] == '.' && (name[1] == '\0' ||
> 				       (name[1] == '.' && name[2] == '\0')))
> 			continue;
> 		if (streq(name, "build") || streq(name, "source"))
> 			continue;
>+
>+	        for (exc = depmod->cfg->excludes; exc != NULL; exc = exc->next) {
>+			if (streq(name, exc->exclude_dir))
>+				exclude = 1;

I'd suggest to add a `break;` here, but even better would be to move
this part to a helper should_skip_dir() so you can simply return
and here we do

		if (should_skip_dir(depmod->cfg, name))
			continue;

Lucas De Marchi

>+		}
>+		if (exclude)
>+			continue;
>+
> 		namelen = strlen(name);
> 		if (scratchbuf_alloc(s_path, baselen + namelen + 2) < 0) {
> 			err = -ENOMEM;
>-- 
>2.31.1
>
