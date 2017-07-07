<?php
namespace Ves\Megamenu\Block\Widget\Products;

/**
 * Interceptor class for @see \Ves\Megamenu\Block\Widget\Products
 */
class Interceptor extends \Ves\Megamenu\Block\Widget\Products implements \Magento\Framework\Interception\InterceptorInterface
{
    use \Magento\Framework\Interception\Interceptor;

    public function __construct(\Magento\Catalog\Block\Product\Context $context, \Ves\Megamenu\Model\Product $productModel, array $data = array())
    {
        $this->___init();
        parent::__construct($context, $productModel, $data);
    }

    /**
     * {@inheritdoc}
     */
    public function getImage($product, $imageId, $attributes = array())
    {
        $pluginInfo = $this->pluginList->getNext($this->subjectType, 'getImage');
        if (!$pluginInfo) {
            return parent::getImage($product, $imageId, $attributes);
        } else {
            return $this->___callPlugins('getImage', func_get_args(), $pluginInfo);
        }
    }
}
