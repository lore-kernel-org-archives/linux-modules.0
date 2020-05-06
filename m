Return-Path: <SRS0=1/+1=6U=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA848C28CBC
	for <linux-modules@archiver.kernel.org>; Wed,  6 May 2020 03:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F2220757
	for <linux-modules@archiver.kernel.org>; Wed,  6 May 2020 03:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgEFD0h (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 5 May 2020 23:26:37 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57179 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgEFD0h (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 5 May 2020 23:26:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TxbzzTU_1588735575;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TxbzzTU_1588735575)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 May 2020 11:26:33 +0800
Subject: Re: [PATCH] libkmod: introduce kmod_module_uniq_options() to improve
 the reliability of loading module
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-modules@vger.kernel.org
References: <20200429155208.97041-1-wenyang@linux.alibaba.com>
 <20200429164442.vx63qh2ioswxa4mf@comp-core-i7-2640m-0182e6>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <de672355-c3d9-9322-5a72-afeb9236e000@linux.alibaba.com>
Date:   Wed, 6 May 2020 11:26:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200429164442.vx63qh2ioswxa4mf@comp-core-i7-2640m-0182e6>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


Dear Alexey,

Thank you for your comments,
we will fix them and send a V2 soon.

Best wishes,
Wen

ÔÚ 2020/4/30 ÉÏÎç12:44, Alexey Gladkov Ð´µÀ:
> On Wed, Apr 29, 2020 at 11:52:08PM +0800, Wen Yang wrote:
>> As in commit 2045cdfa1b40 ("netfilter: nf_conntrack: Fix possible possible crash on module loading"),
>> Loading the nf_conntrack module with doubled hashsize parameter, i.e.
>> 	  modprobe nf_conntrack hashsize=12345 hashsize=12345
>> causes NULL-ptr deref.
>>
>> If 'hashsize' specified twice, the nf_conntrack_set_hashsize() function
>> will be called also twice.
>>
>> In addition, we may also construct the doubled hashsize parameter scenario by using the following configuration:
>>
>> $ cat /etc/modprobe.d/firewalld-sysctls.conf
>> install nf_conntrack /usr/sbin/modprobe --ignore-install nf_conntrack $CMDLINE_OPTS && /usr/sbin/sysctl --quiet --pattern 'net[.]netfilter[.]nf_conntrack.*' --system
>>
>> $ cat /etc/modprobe.d/nf_conntrack.conf
>> options nf_conntrack hashsize=187600
>>
>> $ sudo modprobe nf_conntrack -v
>> install /usr/sbin/modprobe --ignore-install nf_conntrack $CMDLINE_OPTS && /usr/sbin/sysctl --quiet --pattern 'net[.]netfilter[.]nf_conntrack.*' --system hashsize=187500
>> insmod /path/to/nf_conntrack.ko hashsize=187500 hashsize=187500
>>
>> Passing multiple repeated parameters to the kernel may trigger kernel bugs
>> and affect the performance of loading kernel modules.
>>
>> We introduce the nf_conntrack_set_hashsize() and hope to solve this problem.
>>
>> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
>> Cc: Topi Miettinen <toiwoton@gmail.com>
>> Cc: Alexey Gladkov <gladkov.alexey@gmail.com>
>> Cc: linux-modules@vger.kernel.org
>> ---
>>   libkmod/libkmod-module.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   libkmod/libkmod.h        |  1 +
>>   tools/insmod.c           |  7 +++++
>>   3 files changed, 80 insertions(+)
>>
>> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
>> index 76a6dc3..f42beb8 100644
>> --- a/libkmod/libkmod-module.c
>> +++ b/libkmod/libkmod-module.c
>> @@ -1076,6 +1076,72 @@ static char *module_options_concat(const char *opt, const char *xopt)
>>   	return r;
>>   }
>>   
>> +static unsigned int module_options_cnt(const char *opts)
>> +{
>> +	int nr_opts = 0;
>> +	char *saveptr, *tok, *buf;
>> +
>> +	if (!opts)
>> +		return 0;
>> +
>> +	buf = strdup(opts);
>> +	for (tok = strtok_r(buf, " ", &saveptr); tok != NULL;
> 
> Why not use strchr() to find the " " and count them ?
> 
>> +	     tok = strtok_r(NULL, " ", &saveptr), nr_opts++) {}
>> +
> 
> Parameters can have spaces [1]. Is not it so ?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/cmdline.c#n196
> 
>> +	free(buf);
>> +	return nr_opts;
>> +}
>> +
>> +KMOD_EXPORT int kmod_module_uniq_options(char **opts)
>> +{
>> +	char *buf;
>> +	char **array;
>> +	bool duplicated;
>> +	char *saveptr, *tok;
>> +	int nr_opts, len, i, j;
>> +
>> +	if (!opts || !*opts)
>> +		return 0;
>> +
>> +	buf = strdup(*opts);
> 
> We have the options passed as an argument. You doubled it here and tripled
> in the module_options_cnt(). Can you reduce memory usage ?
> 
>> +	if (!buf)
>> +		return  -ENOMEM;
>> +
>> +	len = strlen(buf);
>> +	nr_opts = module_options_cnt(buf);
>> +	array = calloc(nr_opts, sizeof(char *));
>> +	if (!buf)
>> +		return  -ENOMEM;
>> +
>> +	for (tok = strtok_r(buf, " ", &saveptr), i = 0; tok != NULL;
>> +			tok = strtok_r(NULL, " ", &saveptr), i++) {
>> +		array[i] = tok;
>> +	}
>> +
>> +	(*opts)[0] = '\0';
>> +	len = 0;
>> +	for (i = 0; i < nr_opts; i++) {
>> +		duplicated = false;
>> +		for (j = 0; j < i; j++) {
>> +			if (strcmp(array[i], array[j]) == 0) {
>> +				duplicated = true;
>> +				break;
>> +			}
>> +		}
>> +
>> +		if (!duplicated) {
>> +			strcat(*opts, array[i]);
>> +			strcat(*opts, " ");
>> +			len += strlen(array[i]) + 1;
>> +		}
>> +	}
>> +
>> +	(*opts)[len] = '\0';
>> +	free(buf);
>> +	free(array);
>> +	return 0;
>> +}
>> +
>>   static int __kmod_module_get_probe_list(struct kmod_module *mod,
>>   						bool required,
>>   						bool ignorecmd,
>> @@ -1322,6 +1388,12 @@ KMOD_EXPORT int kmod_module_probe_insert_module(struct kmod_module *mod,
>>   		options = module_options_concat(moptions,
>>   					m == mod ? extra_options : NULL);
>>   
>> +		err = kmod_module_uniq_options(&options);
>> +		if (err < 0) {
>> +			free(options);
>> +			return err;
>> +		}
>> +
>>   		if (cmd != NULL && !m->ignorecmd) {
>>   			if (print_action != NULL)
>>   				print_action(m, true, options ?: "");
>> diff --git a/libkmod/libkmod.h b/libkmod/libkmod.h
>> index 3cab2e5..774e52a 100644
>> --- a/libkmod/libkmod.h
>> +++ b/libkmod/libkmod.h
>> @@ -186,6 +186,7 @@ int kmod_module_probe_insert_module(struct kmod_module *mod,
>>   const char *kmod_module_get_name(const struct kmod_module *mod);
>>   const char *kmod_module_get_path(const struct kmod_module *mod);
>>   const char *kmod_module_get_options(const struct kmod_module *mod);
>> +int kmod_module_uniq_options(char **opts);
>>   const char *kmod_module_get_install_commands(const struct kmod_module *mod);
>>   const char *kmod_module_get_remove_commands(const struct kmod_module *mod);
>>   struct kmod_list *kmod_module_get_dependencies(const struct kmod_module *mod);
>> diff --git a/tools/insmod.c b/tools/insmod.c
>> index c422971..2dc0c22 100644
>> --- a/tools/insmod.c
>> +++ b/tools/insmod.c
>> @@ -132,6 +132,13 @@ static int do_insmod(int argc, char *argv[])
>>   		opts[optslen] = '\0';
>>   	}
>>   
>> +	err = kmod_module_uniq_options(&opts);
>> +	if (err < 0) {
>> +		ERR("kmod_module_uniq_options() failed!\n");
>> +		free(opts);
>> +		return err;
>> +	}
>> +
>>   	ctx = kmod_new(NULL, &null_config);
>>   	if (!ctx) {
>>   		ERR("kmod_new() failed!\n");
>> -- 
>> 1.8.3.1
>>
> 
